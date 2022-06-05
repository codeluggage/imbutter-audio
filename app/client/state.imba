import { Song } from './song'
import { Player } from './player'
import { Playlist } from './playlist'
import { HardwareAPI } from '../shared/hardware-api'

class imbutter-state
	api\HardwareAPI
	playlist\Playlist
	player\Player

	constructor
		api = new HardwareAPI()
		playlist = new Playlist()
		player = new Player(api)

		playlist.add(new Song('the answer'))
		playlist.add(new Song('the question'))
		player.playlist = playlist

const state = new imbutter-state()

export default state
