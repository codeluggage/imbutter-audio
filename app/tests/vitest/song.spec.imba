import { Song } from '../../client/song'
import { expect, test, describe } from 'vitest'

describe "Song" do
	test('when created, song is not done') do
		const actual = new Song()
		expect(actual.done).toBe(no)
