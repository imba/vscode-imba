const DEBUGGING = process.env.TSS_DEBUG
let TRACING = null
class Logger
	constructor
		nr = 0
		logs = []
		sent = []
		received = []
		state = {}
		
	get last
		logs[0]
	
	def log ...params
		let ns = params[0]
		let data = params[1]
		let id = ++nr
		state[ns] ||= []
		state[ns].unshift([id].concat(params.slice(1)))
		
		if console.context isa Function
			console.context!.log(...params)
		
		if TRACING
			TRACING.push(params)

		if ns == 'send'
			if data.type == 'event'
				sent.unshift Object.assign({e: data.event},data.body)
			elif data.type == 'response'
				sent.unshift Object.assign({c: data.command},data.body)
		elif ns == 'receive'
			if data.type == 'request'
				received.unshift Object.assign({c: data.command},data.arguments)

		logs.unshift([id,...params])

global.logger = new Logger

export const state = {
	
}

let fillCache = {}

export def trace cb
	let t = TRACING = []
	let res = cb()
	TRACING = null
	return {result: res, logs: t}
	

export def zerofill num, digits = 4
	return fillCache[num] if fillCache[num]
	let str = String(num)
	str = "0000000000".slice(0,9 - str.length) + str
	return fillCache[num] = str.slice(-digits)
	
export def extend target, klass
	let descriptors = Object.getOwnPropertyDescriptors(klass.prototype)
	for own k,v of descriptors
		continue if k == 'constructor' # or !(v.value isa Function)
		let sym = Symbol.for("#{k}")
		target[sym] = target[k] # .bind(target)
		# let prev = Object.getOwnPropertyDescriptor(target,k)
		# console.log "extend?!",k,v,prev
		Object.defineProperty(target,k,v)
		# target[k] = v.value # v.bind(target)
	return target

export def log ...params
	return unless DEBUGGING
	global.logger.log(...params)
	
export def isImba src
	return false unless src
	src.substr(src.lastIndexOf(".")) == '.tsimba'

export def delay target, name, timeout = 500, params = []
	let meta = target.#timeouts ||= {}

	global.clearTimeout(meta[name])
	meta[name] = global.setTimeout(&,timeout) do
		call(target,name,params)

export def cancel target, name
	let meta = target.#timeouts ||= {}
	global.clearTimeout(meta[name])
	delete meta[name]

export def call target,name,params
	cancel(target,name)
	target[name](...params)

export def flush target, name,...params
	let meta = target.#timeouts ||= {}
	call(target,name,params) if meta[name]

export def isPascal str
	let chr = str.charCodeAt(0)
	return chr >= 65 && 90 >= chr

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
		