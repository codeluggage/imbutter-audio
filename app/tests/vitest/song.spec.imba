import { expect, describe, test } from 'vitest'
import { Song } from '../../client/song'

describe 'Song', do
	test 'when created, song is not done', do
		const s = new Song('42')

		const actual = s.progress

		expect(actual).toBe 0.0
