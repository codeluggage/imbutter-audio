import { Song } from './song'

export class Playlist
	#songs\Song[] = []

	get length\number
		#songs.length

	def add(song\Song)
		#songs.push(song)
