import { expect, describe, test } from 'vitest'
import { Playlist } from '../../client/playlist'
import { Player } from '../../client/player'

describe 'when creating a player', do
	test 'it has no playlist', do
		const player = new Player()

		const actual = player.playlist

		expect(actual).toBe Playlist.None

