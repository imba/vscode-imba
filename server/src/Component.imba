import * as config from './Config'

export class Component
	def constructor(...params)
		$timeouts = {}
		self

	get config
		config

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
		if config.get('verbose')
			console.log(...params)
		return
	
	def inspect object
		if config.get('verbose')
			console.dir(object, depth: 10)
		return
		