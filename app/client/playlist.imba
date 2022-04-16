import { Song } from './song'

export class Playlist
	@observable #songs\Song[] = []
	@observable #index = 0

	@computed get length\number
		#songs.length

	def add(song\Song)
		#songs.push(song)

	@computed get currentSong\Song
		return Song.None unless length > 0
		return Song.None unless #index < length
		return Song.None if #index < 0
		
		return #songs[#index]

	def skipForwards\void
		return unless length > 0
		return unless #index < (length - 1)
		
		#index += 1

	def skipBackwards\void
		return unless length > 0
		return unless #index > 0
		
		#index -= 1
