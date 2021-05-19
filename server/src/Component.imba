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
		let item = global.window

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
		
	def lookupKey key
		return null
		
	def lookupRef ids,index = 0
		if typeof ids == 'string'
			ids = ids.split('|')

		let key = ids[index]
		return self if key === null

		let item = lookupKey(key)
		if item
			return item if ids.length == (index + 1)
			return item.lookupRef(ids,index + 1)

	def log ...params
		if config.get('verbose')
			console.log(...params)
		return

	def devlog ...params
		if $web$ or config.get('debug')
			console.log(...params)
		return
	
	def inspect object
		if config.get('verbose')
			console.dir(object, depth: 10)
		return
		