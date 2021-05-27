import EventEmitter from 'events'
import np from 'path'
import cp from 'child_process'

const tsserver = np.resolve(__realname,'..','..','node_modules','typescript','lib','tsserver.js')
const tsplugin = import.worker('./tsplugin')

export class Bridge < EventEmitter
	constructor options = {}
		super
		return self if $web$
		
		args = [
			'--inspect=9576'
			tsserver
			'--allowLocalPluginLoads'
			'--globalPlugins'
			tsplugin.absPath
			'--suppressDiagnosticEvents'
			'--useSingleInferredProject'
			# '--logFile'
			# 'C:/Users/sindr/repos/test-tools/tsserver4.log'
		]

		sent = 0
		nextRequestRef = 1
		pendingRequests = {}
		
		cwd = process.env.IMBASERVER_CWD = (options.cwd or process.env.VSCODE_CWD)
		proc = cp.spawn("node", args, {cwd: cwd, env: process.env})
		
		let readBuffer = ''
		
		proc.stdout.on('data') do(buffer)
			# console.log 'got data!',buffer.length
			readBuffer += buffer.toString('utf8')
			const lines = readBuffer.split('\n')
			readBuffer = ''
			for line of lines
				if line.startsWith('{')
					const msg = JSON.parse(line)
					# console.log 'parsing message',msg
					onmessage(msg)
					
		setTimeout(&,1000) do
			open('__.js')
		self
		
	def onmessage msg
		console.log 'onmessage',msg.type,msg.event,msg.responseRef

		if let id = msg.responseRef
			let request = pendingRequests[id]
			let took = Date.now! - request.#sent
			console.log 'msg response took',took
			request.#resolve(msg.body)
			delete pendingRequests[id]
		elif msg.command == 'configurePlugin'
			yes
		else
			if msg.type == 'event'
				emit(msg.event,msg.body)
		
	def pathify src
		np.resolve(cwd,src)
	
	def send cmd
		cmd.seq = sent++
		# console.log "sending command",cmd
		proc.stdin.write(JSON.stringify(cmd) + '\r\n', 'utf8')
			
	def open file
		send { "type": "request", "command": "open", "arguments": { "file": pathify(file) }}

	def request payload
		# getCompletionEntrySymbol(fileName: string, position: number, name: string, source: string | undefined): Symbol | undefined;
		let ev = {
			type: "request",
			command: "configurePlugin",
			arguments: {
				pluginName: 'imba'
				configuration: payload
			}
		}
		ev.#sent = Date.now!
		ev.#promise = new Promise do(resolve) ev.#resolve = resolve
		let ref = payload.requestRef = nextRequestRef++
		pendingRequests[ref] = ev
		send(ev)
		return ev.#promise
	
	def rpc name, ...params
		request(type: name, params: params)

def start
	let bridge = new Bridge
	
	bridge.open('__.js')
	# bridge.open('nested/__.js')
	# bridge.open('other/__.js')
	setInterval(&,5000) do
		let response = await bridge.request(type: "ping", stuff: [1,2,3])
		console.log 'got response',response
	return bridge

# start!