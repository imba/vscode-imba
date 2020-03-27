var content = `<div.one.two title=10 :click.test>`
import {File} from './File'
import {LanguageServer} from './LanguageServer'
import * as util from './utils'
import { parse,TokenizedDocument } from './Parser'
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
		let stack = []
		let part = tok.stack
		while part
			stack.unshift(part.state)
			part = part.parent
		stack = stack.join('>')

		if stack != prevstack
			prevstack = stack
		else
			stack = ''

		console.log [tok.offset,tok.value,tok.type,stack]

	for offset in locs
		let ctx = tmpdoc.tokens.getContextAtOffset(offset)
		ctx.vars = ctx.vars.map do $1.value
		for own k,v of ctx
			if v and v.language == 'imba'
				ctx[k] = [v.offset,v.value,v.type]
		console.log [ctx.state,ctx.line,ctx.vars,ctx.scope,ctx.token]

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

// testparse('<div>')
// testparse('<div.one.two :click.stop value=10>')
// testparse('<div .one value=10 .two>')
// testparse('<div .one=(test)>')
// testparse('<div .one-{state}-here>')
// testparse('<div .one-{state)}-here>')
// testparse('<div[item]>')
// testparse('<div title="hello">')
// testparse('<div :test.§self.stop>')
// testparse('<div x=(<b>) .§test>')

testparse(`
if true
	let one-two = 1
	var func = do(fone,ftwo)
		let hello = fone
		§
`)

testparse(`
	let x = 1
	for item,i in [1,2,3]
		item§
`)

testparse(`
	let x = 1
	for own key,value of obj
		key§
`)

testparse(`
	let x = \{
		one: 1
		two: §
		test: 2
	}
`)

testparse(`
var a = 10

§

let x = 20
`)

testparse(`
var a = \{b: 10\}
20
`)

testparse('var x\\Array§')

testparse('var x = `hello`\n100')

testparse(`
if true
	1

§
if true §
	2
`)

testparse(`<div :§click§.§stop§>`)

if false
	let file = ls.getImbaFile('context.imba')
	let doc = ImbaTextDocument.new('file://test.imba','imba',0,file.doc.getText!)
	# console.log doc.tokens.getTokens(line: 2)
	# console.log doc.tokens.getTokens(line: 100)
	# console.log doc.tokens.getTokens(line: 103)
	let locs = [
		22,25,86,119,155,161,
		200,229,239,277,
		300,331,364,365,368,
		411,432,463,479,480,492,493,
		510,532,544,554,622,304,632,639,644,651,
		677
		]
	for offset in locs
		let pos = doc.positionAt(offset)
		let ctx = doc.tokens.getContextAtOffset(offset)
		let line = doc.tokens.lineTokens[pos.line]
		let idx = offset - line.offset
		let prev = doc.tokens.lineTokens[pos.line - 1]
		let str = line.lineContent.slice(0,idx) + '|' + line.lineContent.slice(idx)
		console.log ['---',prev.lineContent,str,'---'].join('\n').replace(/\t/g,'  ')
		console.log ctx.value,ctx.type,ctx.stack.state
		# console.dir [ctx.value,ctx.type,ctx.stack.state], depth: 1


# ls.getCompletionsAtPosition('completion.imba',88)
# console.log ls.getImbaFile('completion.imba').getContextAtLoc(89)
# ls.emitDiagnostics()