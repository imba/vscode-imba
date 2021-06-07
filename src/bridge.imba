import ipc from 'node-ipc'

import * as util from './util'

export default class Host
	constructor api
		self.id = "imba-ipc-{String(Math.random!)}"
		self.api = api
		self.reqs = 0
		
		sent = 0
		nextRequestRef = 1
		pendingRequests = {}
		
		serve!
		self
		
	def serve
		ipc.config.id = id		
		ipc.serve do
			util.log('ipc serving on ' + id)
			ipc.server.on('message') do(data,socket) handle(data,socket)
			emit('ready')
		ipc.server.start!
		
	def ping
		emit('ping', ref: reqs++)

	def emit name, body = {}
		send(type: 'event', event: name, body: body)
		
	def handle e, socket = null
		let now = Date.now!
		let elapsed = now - e.ts
		util.log("ipc.onmessage {JSON.stringify(e).slice(0,20)} transferred in {elapsed}ms")
		
		if e.type == 'response'
			if let id = e.responseRef
				let request = pendingRequests[id]
				let took = Date.now! - request.ts
				util.log("msg response took {took}ms")
				request.#resolve(e.body)
				delete pendingRequests[id]
		self
	
	def call method, ...params
		let ev = {
			type: 'request'
			requestRef: nextRequestRef++
			command: method
			arguments: params
			ts: Date.now!
		}
		ev.#promise = new Promise do(resolve) ev.#resolve = resolve
		pendingRequests[ev.requestRef] = ev
		send(ev)
		return ev.#promise
		
	def send msg
		let cfg = {id: id, data: msg}
		self.api._pluginManager._onDidUpdateConfig.fire({ pluginId: 'imba',config: cfg})