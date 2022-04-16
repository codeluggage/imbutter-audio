import { expect, describe, test } from 'vitest'
import { Playlist } from '../../client/playlist'
import { Player } from '../../client/player'

describe 'when creating a player', do
	test 'it has no playlist', do
		const player = new Player()

		const actual = player.playlist

		expect(actual).toBe Playlist.None

	test 'it is stopped', do
		const player = new Player()

		const actual = player.playing

		expect(actual).toBe false

	test 'playing does nothing', do
		const player = new Player()

		player.play()
		const actual = player.playing

		expect(actual).toBe false

	test 'stopping does nothing', do
		const player = new Player()

		player.stop()
		const actual = player.playing

		expect(actual).toBe false
