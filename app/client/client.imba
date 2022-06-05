import state from './state'

tag App
	def play
		if state.player.playing
			state.player.pause()
		else
			state.player.play()

	def render
		<self[d:flex fld:column pos:absolute inset:0]>
			<button @click=play> "Play"
			# <form[d:flex bg:gray2 p:2 m:0] @submit.prevent=add($input.value)>
			# 	<input$input[flex:1 p:1 bg:clear] placeholder="What's your jam?">
			<div> state.player.progress

			<ul[flex:1 px:1]> for song in state.player.playlist.#songs
				<li[bc:gray2 bbw:1 p:2 fw:500]> # [td:s c:gray6 fw:400]=song.progress>
					<span> song.title
			<footer[bg:gray2 p:3]>
				<span> "You have {state.player.playlist.length} songs"

imba.mount <App autorender=10fps>
