import { vi, expect, describe, test } from 'vitest'
import { Playlist } from '../../client/playlist'
import { Song } from '../../client/song'
import { Player } from '../../client/player'

describe 'when creating a player', do
	test 'it has no playlist', do
		const p = new Player()

		const actual = p.playlist

		expect(actual).toBe Playlist.None

	test 'it is stopped', do
		const p = new Player()

		const actual = p.playing

		expect(actual).toBe false

	test 'playing does nothing', do
		const p = new Player()

		p.play()
		const actual = p.playing

		expect(actual).toBe false

	test 'stopping does nothing', do
		const p = new Player()

		p.stop()
		const actual = p.playing

		expect(actual).toBe false

describe 'when adding one playlist to a player', do
	test 'playing does nothing if playlist is empty', do
		const p = new Player()

		p.play()
		const actual = p.playing

		expect(actual).toBe false

	test 'playing begins if playlist is not empty', do
		const p = new Player()
		const playlist = new Playlist()
		playlist.add(new Song('42'))
		p.playlist = playlist

		p.play()
		const actual = p.playing

		expect(actual).toBe true

describe 'when playing', do
	test 'it can stop', do
		const p = new Player()
		const playlist = new Playlist()
		playlist.add(new Song('42'))
		p.playlist = playlist
		p.play()

		p.stop()
		const actual = p.playing

		expect(actual).toBe false

	test 'it tracks progress', do
		const now = Date.now()
		vi.useFakeTimers()
		vi.setSystemTime(now - 1000)
		const p = new Player()
		const playlist = new Playlist()
		playlist.add(new Song('42'))
		p.playlist = playlist
		p.play()

		const first = p.progress
		vi.setSystemTime(now)
		const actual = p.progress

		vi.useRealTimers()

		expect(actual).toBeCloseTo first + 1

	test 'does not progress when paused', do
		const now = Date.now()
		vi.useFakeTimers()
		vi.setSystemTime(now - 1000)
		const p = new Player()
		const playlist = new Playlist()
		playlist.add(new Song('42'))
		p.playlist = playlist
		p.play()

		vi.setSystemTime(now)
		p.pause()
		vi.setSystemTime(now + 1000)
		const actual = p.progress

		vi.useRealTimers()
		expect(actual).toBeCloseTo 1

	test 'progressed after being unpaused', do
		const now = Date.now()
		vi.useFakeTimers()
		vi.setSystemTime(now - 1000)
		const p = new Player()
		const playlist = new Playlist()
		playlist.add(new Song('42'))
		p.playlist = playlist
		p.play()

		vi.setSystemTime(now)
		p.pause()
		vi.setSystemTime(now + 1000)
		p.play()
		vi.setSystemTime(now + 2000)
		const actual = p.progress

		vi.useRealTimers()
		expect(actual).toBeCloseTo 1
