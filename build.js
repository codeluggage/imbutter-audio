const util = require("util")
const childProcess = require("child_process")
const fs = require("fs/promises")
const path = require("path")

const exec = util.promisify(childProcess.exec)

async function runBuild() {
  const targetPath = "./dist/html"

  // clear out build directory
  await fs.rmdir("./dist/", { recursive: true })

  // run the imba build command
  await exec('imba build --baseurl "." server.imba')

  // make a directory to store my custom build
  await fs.mkdir(targetPath)

  // move and rename the HTML file
  await fs.rename(
    "./dist/public/index.html",
    path.join(targetPath, "index.html")
  )

  // find the correct CSS file (this version of imba references the incorrect file)
  const cssBasePath = "./dist/public/__assets__/"
  const cssFileName = await findFileByRegex(cssBasePath, /__styles__\..*\.css/)

  // find the other CSS file (this one is referenced by the link tag)
  const referencedCssBasePath = "./dist/public/__assets__/app"
  const referencedCssFileName = await findFileByRegex(
    referencedCssBasePath,
    /client\..*\.css$/
  )

  // move and rename the CSS file
  await fs.rename(
    path.join(cssBasePath, cssFileName),
    path.join(targetPath, "style.css")
  )

  // find the JS file
  const jsBasePath = "./dist/public/__assets__/app/"
  const jsFileName = await findFileByRegex(jsBasePath, /client\..*\.js$/)

  // remove sourcemap reference from script
  await replaceTextInFile(
    path.join(jsBasePath, jsFileName),
    /\/\/\# sourceMappingURL=\.\/__assets__\/\/app\/\/client\..*\.js\.map/,
    ""
  )

  // move and rename the JS file
  await fs.rename(
    path.join(jsBasePath, jsFileName),
    path.join(targetPath, "client.js")
  )

  // remove the type="module" attribute from the script tag
  await replaceTextInFile(
    path.join(targetPath, "index.html"),
    'type="module" ',
    ""
  )

  // update filename in script tag
  const existingScriptTagSrc = path.join("./__assets__/app/", jsFileName)
  await replaceTextInFile(
    path.join(targetPath, "index.html"),
    existingScriptTagSrc,
    "client.js"
  )

  // update filename in style tag
  const existingLinkTagHref = path.join(
    "./__assets__/app/",
    referencedCssFileName
  )
  await replaceTextInFile(
    path.join(targetPath, "index.html"),
    existingLinkTagHref,
    "style.css"
  )

  // TODO: Android
  // const androidDir = "./android/App/App/public"
  // await fs.rmdir(androidDir, { recursive: true })
  // await fs.copy(targetPath, androidDir)

  // replace and move to app directories
  const iosDir = "./ios/App/App/public"
  await fs.rmdir(iosDir, { recursive: true })
  await fs.rename(targetPath, iosDir)
}

async function replaceTextInFile(path, regex, replaceWith) {
  const data = await fs.readFile(path, "utf8")
  const result = data.replace(regex, replaceWith)
  await fs.writeFile(path, result, "utf8")
}

async function findFileByRegex(base, regex) {
  const files = await fs.readdir(base)
  const filtered = files.filter(function (filePath) {
    return filePath.match(regex) !== null
  })
  return filtered[0]
}

runBuild()

