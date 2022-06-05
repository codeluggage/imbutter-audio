
const hw-root = 'http://localhost:8080'

const hw-audio-play = 'play'

def api-post functionality\string, action\string, params\Object, cb # \(Function | undefined)
	const path = "{hw-root}/{functionality}/{action}"
	const payload = 
		method: 'POST'
		headers:
			'Content-Type': 'application/json'
		body: JSON.stringify params
	
	if cb
		return window.fetch(path, payload).then(cb).catch(cb)
	else
		return window.fetch(path, payload)


export class HardwareAPI
	# TODO: Should the "Song" type be expected here?
	def play song\String, cb # \(Function | undefined)
		if cb
			return api-post "just_audio", hw-audio-play, { song: song }, cb
		else
			await api-post "just_audio", hw-audio-play, { song: song }
