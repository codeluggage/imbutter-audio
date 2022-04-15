// To create new tests, record them instead of writing them:
//
// 1) Generate test steps with "npm run test:e2e-codegen".
// 2) Change the initial `page.goto` so it uses "/".

import { test } from '@playwright/test'

test('test', async ({ page }) => {
  // Go to http://localhost:3000/
  await page.goto('/')

  // Click li:has-text("Hello") >> nth=0
  await page
    .locator('li:has-text("Hello")')
    .first()
    .click()

  // Click text=Archive
  await page.locator('text=Archive').click()

  // Click ul:has-text("Hello again")
  await page.locator('ul:has-text("Hello again")').click()

  // Click [placeholder="What\'s your jam\?"]
  await page.locator('[placeholder="What\\\'s your jam\\?"]').click()

  // Fill [placeholder="What\'s your jam\?"]
  await page.locator('[placeholder="What\\\'s your jam\\?"]').fill('TDD!')

  // Press Enter
  await page.locator('[placeholder="What\\\'s your jam\\?"]').press('Enter')

  // Click li:has-text("TDD!")
  await page.locator('li:has-text("TDD!")').click()

  // Click li:has-text("Hello again")
  await page.locator('li:has-text("Hello again")').click()

  // Click li:has-text("TDD!")
  await page.locator('li:has-text("TDD!")').click()

  // Click li:has-text("Hello again")
  await page.locator('li:has-text("Hello again")').click()

  // Click text=Hello againTDD!
  await page.locator('text=Hello againTDD!').click()
})
