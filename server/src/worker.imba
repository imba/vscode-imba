###
Script for compiling imba and imba1 files inside workers using
workerpool. 
###

const imbac = require 'imba/compiler'
const imba1c = require '../imba1.compiler.js'

const workerpool = require('workerpool')

const id = Math.random!

def compile_imba code, options
	let out = {id: options.sourceId}
	let res = null
	
	try
		res = imbac.compile(code,options)
	catch e
		console.log "ERROR COMPILING IMBA",e,options.sourcePath
		res = {}

	for item in res.diagnostics
		item.lineText = item.#lineText

	if res.warnings
		out.warnings = res.warnings

	if res.errors
		out.errors = res.errors

	let js = res.js

	# clean up the trims now
	out.js = js
	out.locs = res.locs
	out.css = res.css
	return out


def compile_imba1 code,options
	options.target = 'web' if options.target == 'browser'
	let out = {id: options.sourceId, warnings: [], errors: []}
	let res = imba1c.compile(code,options)
	let js = res.js

	if js.indexOf('$_ =') > 0
		js = "var $_;\n{js}"
	
	out.js = js

	return out

console.log "logging from worker!!!",globalThis
workerpool.worker(
	compile_imba: compile_imba
	compile_imba1: compile_imba1
)