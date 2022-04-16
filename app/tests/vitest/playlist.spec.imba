import { expect, describe, test } from 'vitest'
import { Playlist } from '../../client/playlist'
import { Song } from '../../client/song'

describe 'when creating a playlist', do
	test 'it is empty', do
		const p = new Playlist()

		const actual = p.length

		expect(actual).toBe 0

	test 'it has no current song', do
		const p = new Playlist()

		const actual = p.currentSong

		expect(actual).toBe Song.None

describe 'when adding one song', do
	test 'it increases the length', do
		const p = new Playlist()
		const s = new Song('42')

		p.add(s)
		const actual = p.length

		expect(actual).toBe 1

	test 'it updates the current song', do
		const p = new Playlist()
		const s = new Song('42')
		p.add(s)

		const actual = p.currentSong

		expect(actual).toBe s

describe 'when adding songs', do
	test 'it does not change the current song', do
		const p = new Playlist()
		const s = new Song('42')
		p.add(s)
		p.add(new Song('the answer'))

		const actual = p.currentSong

		expect(actual).toBe s

describe 'when skipping forwards', do
	test 'it does nothing when empty', do
		const p = new Playlist()

		p.skipForwards()
		const actual = p.currentSong

		expect(actual).toBe Song.None

	test 'it does nothing when there is only one song', do
		const p = new Playlist()
		const s = new Song('42')
		p.add(s)

		p.skipForwards()
		const actual = p.currentSong

		expect(actual).toBe s

	test 'it goes to the next song', do
		const p = new Playlist()
		const s1 = new Song('1')
		const s2 = new Song('2')
		p.add(s1)
		p.add(s2)

		p.skipForwards()
		const actual = p.currentSong

		expect(actual).toBe s2


describe 'when skipping backwards', do
	test 'it does nothing when empty', do
		const p = new Playlist()

		p.skipBackwards()
		const actual = p.currentSong

		expect(actual).toBe Song.None

	test 'it does nothing when there is only one song', do
		const p = new Playlist()
		const s = new Song('42')
		p.add(s)

		p.skipBackwards()
		const actual = p.currentSong

		expect(actual).toBe s

	test 'it goes to the previous song', do
		const p = new Playlist()
		const s1 = new Song('1')
		const s2 = new Song('2')
		p.add(s1)
		p.add(s2)

		p.skipForwards()
		p.skipBackwards()
		const actual = p.currentSong

		expect(actual).toBe s1

