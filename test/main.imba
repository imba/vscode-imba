
import {Util} from './util'
import './setup'
import './component.js'
import {items} from './data'

Util.bind()
Util.ping()

let u = Util.new()
u.state = 'test'
u.add(1,2)

tag app-root
	@hello
	def setup
		self

	def render
		<self title='roots'>
			for item in items
				<div title=item.name>
			<app-todo title='one' kind=1> "Hello"
			<app-todo item='two' kind=2> "Hello"
			<app-todo title='three'> "Hello"
			<app-link title='three'> "Hello"
			<app-item title='three'> "Hello"

# let ext = Extern.new
# ext.hello()