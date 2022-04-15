import { Song } from './song.imba'

tag App
	prop songs = [new Song('Hello'), new Song('Hello again')]

	def add title
		songs.push(new Song(title))
		$input.value = ''

	def archive
		songs = songs.filter(do !$1.done)

	def render
		<self[d:flex fld:column pos:absolute inset:0]>
			<form[d:flex bg:gray2 p:2 m:0] @submit.prevent=add($input.value)>
				<input$input[flex:1 p:1 bg:clear] placeholder="What's your jam?">
			<ul[flex:1 px:1]> for item in songs
				<li[bc:gray2 bbw:1 p:2 fw:500] [td:s c:gray6 fw:400]=item.done @click=item.toggle>
					<span> item.title
			<footer[bg:gray2 p:3]>
				<span> "You have {songs.length} songs"
				<button @click=archive> "Archive"

imba.mount <App>
