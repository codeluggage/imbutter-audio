export class Song
	title = '<No title>'
	done = no

	constructor title
		title = title

	def archive
		yes

	def toggle
		done = !done
