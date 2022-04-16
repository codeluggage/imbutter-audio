import { Song } from './song'

export class Playlist
	static None = new Playlist()

	@observable #songs\Song[] = []
	@observable #index = 0

	@computed get length\number
		#songs.length

	@action def add(song\Song)
		#songs.push(song)

	@computed get currentSong\Song
		return #songs[#index] or Song.None

	@action def skipForwards\void
		#index += 1 if #songs[#index + 1]

	@action def skipBackwards\void
		#index -= 1 if #songs[#index - 1]
