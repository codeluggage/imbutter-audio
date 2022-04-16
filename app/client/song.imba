export class Song
	static None = new Song('<None>')

	title\string
	progress\number

	constructor title\string
		title = title
		progress = 0.0
