import * as pc from 'patcom'
import { Playlist } from './playlist'

export class Player
	static NoneTime = new Date(0)

	playlist = Playlist.None
	@observable playing = false
	@observable started = Player.NoneTime
	@observable paused = Player.NoneTime
	@observable stopped = Player.NoneTime

	get progress\number
		const hold = 
			playing: playing
			started: started
			paused: paused 
		
		console.log 'hold', hold

		return pc.match(hold)(
			pc.when {
				started: Player.NoneTime
				paused: pc.not(Player.NoneTime)
				playing: false
			}, do({ playing, started, paused })
				console.log
					what: '1'
					started: started
					paused: paused
					playing: playing
				return 0

			pc.when {
				started: pc.defined
				paused: Player.NoneTime
				playing: true
			}, do({ playing, started, paused })
				console.log
					what: '2'
					started: started
					paused: paused
					playing: playing
				return (started.getTime() - Date.now()) / 1000

			pc.when {
				started: pc.defined
				paused: pc.defined
				playing: true
			}, do({ playing, started, paused })
				console.log
					what: '3'
					started: started
					paused: paused
					playing: playing
				const now = Date.now()
				const pausedAt = now - paused.getTime()
				const startedAt = now - started.getTime()
				const elapsedDuringPause = pausedAt - startedAt
				const elapsed = (startedAt + elapsedDuringPause) / 1000
				# console.log
				# 	now
				# 	pausedAt
				# 	startedAt
				# 	elapsedDuringPause
				# 	elapsed

				return elapsed

			pc.otherwise do({ playing, started , paused })
				console.log
					what: 'otherwise'
					started: started
					paused: paused
					playing: playing
				return 0
		)

	def play\void
		return if playing
		return if playlist.isEmpty
		playing = true
		started = new Date() if started == Player.NoneTime
		stopped = Player.NoneTime
		paused = Player.NoneTime

	def pause\void
		return unless playing
		return if playlist.isEmpty
		playing = false
		paused = new Date()

	def stop\void
		return unless playing
		playing = false
		stopped = new Date()

