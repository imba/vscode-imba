let items = [
	id: 1
	name: 'other'
	-
	id: 2
	name: 'Again'
	a: 10
]

tag app-item
	prop item = []
	prop category
	
	def hello
		"test"

tag app-todo < app-item
	prop titl = "10"
	prop item
	prop todo

	def other
		schedule!
		# @hello().toUpperCase()
		# @hanimate()
		this

	set kind value
		# #value = value
		
		true
	
	def render
		<self> todo.title

tag app-link < a
	
	def hello
		href = '#'
		self

tag app-header < label

	def hello
		self