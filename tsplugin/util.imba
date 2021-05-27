const DEBUGGING = process.env.TSS_DEBUG

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