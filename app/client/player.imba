import { Timeout } from '../lib/managed-timeout/timeout'
import { Playlist } from './playlist'
import { HardwareAPI } from '../shared/hardware-api'

const STATIC_TIME = 15 * 1000

export class Player
	static NoneTime = new Date(0)

	playlist = Playlist.None
	api\HardwareAPI = undefined
	@observable playing = false
	@observable timer = new Timeout(0)

	constructor api\HardwareAPI
		api = api

	get progress\number
		timer.timePassed / 1000

	def finished\void
		console.log 'finished: ' + timer.timePassed

	def play\void
		return if playing
		return if playlist.isEmpty
		# How do do callbacks here?
		api.play(playlist.currentSong.title)
		playing = true
		timer.reset(STATIC_TIME)
		timer.start(finished)
		return # How to tell imba to not use return value?

	def pause\void
		return unless playing
		return if playlist.isEmpty
		playing = false
		timer.pause()

	def stop\void
		return unless playing
		playing = false
		timer.cancel()
		return # How to tell imba to not use return value?
