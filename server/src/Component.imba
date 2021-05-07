import * as config from './Config'
import * as util from './utils'

export class Component
	def constructor(...params)
		$timeouts = {}
		self

	get config
		config

	get util
		util

	def $delay name, timeout = 500
		global.clearTimeout($timeouts[name])
		$timeouts[name] = global.setTimeout(&,timeout) do $call(name)

	def $cancel name
		global.clearTimeout($timeouts[name])
		delete $timeouts[name]

	def $call name,...params
		$cancel(name)
		self[name](...params)

	def $flush name,...params
		$call(name,...params) if $timeouts[name]
		
	def $stamp label = 'time'
		#prev ||= Date.now!
		let now = Date.now!
		console.log "{label}: {now - #prev}"
		#prev = now
		self

	def log ...params
		if config.get('verbose')
			console.log(...params)
		return

	def devlog ...params
		if $web$
			console.log(...params)
		return
	
	def inspect object
		if config.get('verbose')
			console.dir(object, depth: 10)
		return
		