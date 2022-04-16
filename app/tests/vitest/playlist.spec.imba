import { expect, describe, test } from 'vitest'
import { Playlist } from '../../client/playlist'
import { Song } from '../../client/song'

describe 'Playlist', do
	test 'when creating a Playlist, it is empty', do
		const p = new Playlist()

		const actual = p.length

		expect(actual).toBe 0

	test 'when adding a song, it increases the length', do
		const p = new Playlist()
		const s = new Song()

		p.add(s)
		const actual = p.length

		expect(actual).toBe 1
