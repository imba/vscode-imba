var content = `<div.one.two title=10 :click.test>`
import {File} from './File'
import {LanguageServer} from './LanguageServer'
import * as util from './utils'
import { TokenizedDocument } from './Parser'
import { FullTextDocument,ImbaTextDocument } from './FullTextDocument'
var imbac = require 'imba/dist/compiler.js'

var conn = {
	sendDiagnostics: do yes
}

var rootFile = '/Users/sindre/repos/vscode-imba/test/main.js'
var ls = LanguageServer.new(conn,null,{
	rootUri: 'file:///Users/sindre/repos/vscode-imba/test'
	rootFiles: []
	debug: true
})
ls.addFile(rootFile)
ls.addFile('completion.js')

ls.emitRootFiles!

def toffset2ioffset file, start, length
	let iloc = file.originalLocFor(start)
	let range = file.textSpanToRange({ start: start, length: length })
	console.log "orig offset",start,length,iloc,range
	

if false
	let file = ls.getImbaFile('completion.imba')
	let compiled-offset = file.generatedLocFor(54)
	console.log "hello",compiled-offset
	let res = ls.tls.getCompletionsAtPosition(file.jsPath,compiled-offset,{
		includeCompletionsWithInsertText: true
		includeCompletionsForModuleExports: true
		disableSuggestions: true
	})
	for item in res.entries
		for own k,v of item
			delete item[k] if v == undefined
		if item.name.match(/status|innerWidth|onpopstate|Reflect|param|setTimeout/) or item.insertText
			console.log item
	# console.log res.entries
	

let tmpdoc = FullTextDocument.new('','imba',0,'')

def testparsex code
	return

def testparse code

	console.log "\nparsing ---"
	console.log code

	let locs = []

	while code.indexOf('§') >= 0
		locs.push(code.indexOf('§'))
		code = code.replace(/§/,'')

	tmpdoc.overwrite(code)
	let tokens = tmpdoc.tokens.getTokens!
	let prevstack = ""
	for tok in tokens
		let stacks = []
		let part = tok.stack
		while part
			stacks.unshift(part.state)
			part = part.parent
		let stack = stacks.join('>')

		if stack != prevstack
			prevstack = stack
		else
			stack = ''
		if tok.type == 'white'
			continue
		console.log [tok.offset,tok.value,tok.type,stack]

	for offset in locs
		let ctx = tmpdoc.tokens.getContextAtOffset(offset)
		ctx.vars = ctx.vars.map do $1.value
		for own k,v of ctx
			if v and v.language == 'imba'
				ctx[k] = [v.offset,v.value,v.type]
		console.log [ctx.mode,ctx]

let parses = `
require('§fs')
class One
	def again
		var x = do(a,§b) true
		true


	def setup par1,par2
		let [
			a1
			a2
		] = [1,2]
		if let h1 = 1
			let h2 = 2
		let meth = do(h3,h4)
			let h5 = 2
			test

		Math.ceil(
			let i1 = 0.5
		)

		let str = '
	test dette her
		'

		if let if1 = 1
			let s1 = 1
				
		let s2 = 2
		

tag §app-item
	prop value = 10
	get value
		$value

	set value val
		$value = val

	static def §init
		// comment§ here
		let regex = /§hello/
	
		self

	def render param
		let a = 1
		<self>
			<div> "title"
			<span :click.stop> "test"
			<span title= "hello"> "test"
### css
.test \{
	display: block;
\}
###
`


testparse(`
def mount
	if true
		let something = 10
		let other = 20

	if true
		let again = 1
		let fn = do(a,b,c) a + b + c
		let test = again + 2
		for rev,k in repo.children
			test + 10 + k + §1
		let regex = /tester/
		regex + test + §
`)