const np = require 'path'
const workerPool = require 'workerpool'
# temporary hack - we know that we compile to bin/
# const workerScript = np.resolve(__dirname,'..','dist','compiler-worker.js')
const workerScript = import.worker('./worker')
# const workerScript = np.resolve(__dirname,'..','workers.imba.js')
# #workers ||= workerPool.pool(workerScript, maxWorkers:2)

let pool = null
let refs = 0

console.log "starting pool with script",workerScript.absPath

def incr
	refs += 1
	pool ||= workerPool.pool(workerScript.absPath, maxWorkers:2)

def decr
	refs -= 1
	if refs < 1 and pool
		pool.terminate!

export def compile_imba code, o
	incr!
	pool.exec('compile_imba', [code,o])

export def compile_imba1 code, o
	incr!
	pool.exec('compile_imba1', [code,o])

def run
	let a = compile_imba("let y = 100\n",{sourceId: 'aba',sourcePath: 'item.test'})
	let b = await compile_imba("let x = 100\n",{sourceId: 'aba',sourcePath: 'item.test'})
	console.log await a
	console.log b
	yes
# 	
# run!
	
