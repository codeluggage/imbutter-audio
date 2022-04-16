import { Playlist } from './playlist'

export class Player
	static Stopped = new Date()

	playlist = Playlist.None
	@observable playing = false
	@observable started = Player.Stopped
	@observable stopped = Player.Stopped

	def play\void
		return

	def stop\void
		return

