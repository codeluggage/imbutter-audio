export class Todo
	attr someattr
	attr preattr = 'hello'

	constructor title
		title = title
		done = no

	def archive
		yes

	def toggle
		done = !done

# tag A
# 	attr someattr
# 	attr preattr = 'hello'

test 'attr declaration' do
	let el = <Todo someattr=1>
	ok el.hasAttribute('someattr')

test 'attr default' do
	let el = <Todo>
	eq el.getAttribute('preattr'), 'hello'
