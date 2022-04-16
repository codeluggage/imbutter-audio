# import * as pc from 'patcom'
import { Song } from './song'

export class Playlist
	@observable #songs\Song[] = []
	@observable #index = 0

	@computed get length\number
		#songs.length

	def add(song\Song)
		#songs.push(song)

	@computed get currentSong\Song
		return #songs[#index] or Song.None

	def skipForwards\void
		#index += 1 if #songs[#index + 1]

	def skipBackwards\void
		#index -= 1 if #songs[#index - 1]
