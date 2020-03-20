export class Component
	def constructor(...params)
		$timeouts = {}
		self

	def $delay name, timeout = 500
		global.clearTimeout($timeouts[name])
		$timeouts[name] = global.setTimeout(&,timeout) do $call(name)

	def $cancel name
		global.clearTimeout($timeouts[name])
		delete $timeouts[name]

	def $call name
		$cancel(name)
		self[name]()

	def $flush name
		$call(name) if $timeouts[name]

	def log ...params
		# console.log(...params)
		return
	
	def inspect object
		# console.dir(object, depth: 10)
		return
		