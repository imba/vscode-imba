var content = `<div.one.two title=10 :click.test>`
import {File} from './File'
import {LanguageServer} from './LanguageServer'
import * as util from './utils'
import { parse,TokenizedDocument } from './Parser'
import { FullTextDocument,ImbaTextDocument } from './FullTextDocument'
var imbac = require 'imba/dist/compiler.js'

var tests  = [
	[`<div.one.two title=10 :click.test>`,4]
	[`<div >`,5]
	[`<div :click.stop .test=10>\n`,12,18,23]
	[`<\{name\} title='a'>\n`,7]
	[`<div :test.call(10,200)>\n`,19]
	[`if true\n\tMath.random()\n`,2]
	[`\n<>\n<li> 'test'`,2]
	[`<div> <span> 'test'`,5]
]

if false
	var file = File.new({files: {}, rootFiles: []},'index.imba')

	for test in tests
		file.content = test[0]
		for pos in test.slice(1)
			console.log file.getContextAtOffset(pos)

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
# console.log ls.rootFiles
ls.emitRootFiles()

if false
	ls.getSemanticDiagnostics()
	ls.$updateFile('component.imba') do |content| content.replace(/@titl\b/,'@titls')
	ls.getSemanticDiagnostics()
	ls.$updateFile('component.imba') do |content| content.replace(/@titls\b/,'@titl')
	ls.getSemanticDiagnostics()
	ls.inspectProgram()

	ls.getSemanticDiagnostics()
	console.log ls.getSymbols('util.imba')
	
def toffset2ioffset file, start, length
	let iloc = file.originalLocFor(start)
	let range = file.textSpanToRange({ start: start, length: length })
	console.log "orig offset",start,length,iloc,range

let tmpdoc = FullTextDocument.new('','imba',0,'')

def testparsex code
	return

def testparse code
	console.log "\nparsing ---"
	console.log code
	let pos = code.indexOf('§')
	code = code.replace(/§/g,'')
	# let res = parse(code)
	tmpdoc.overwrite(code)
	let tokens = tmpdoc.tokens.getTokens!
	for tok in tokens
		console.log [tok.offset,tok.value,tok.type]

	if pos >= 0
		let ctx = tmpdoc.tokens.getContextAtOffset(pos)
		ctx.vars = ctx.vars.map do $1.value
		# for scope in ctx.scopes when scope.name
		#	scope.name = scope.name.value
		console.log ctx

if false
	let file = ls.getImbaFile('completion.imba')
	let content = file.doc.getText!
	let last = 0
	let idx = 0

	while (idx = content.indexOf('# |',last)) > -1
		last = idx + 2
		if let m = content.slice(idx + 3).match(/^\d+/)
			idx = idx - parseInt(m[0])

		console.log 'found index',idx
		console.dir file.getContextAtOffset(idx), {depth: 7}


let parses = `
class One
	def again
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
		

tag app-item
	prop value = §10
	get value
		$value

	set value val
		$value = val

	static def init
		
		self

	def render
		<self>
			<div>
			
`

if true
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
	
	// testparse('<div x="hello there {§}">')
	# testparse('if let y = 1\n\tlet x = true\ntrue')
	# testparse("var x = 'a\ns§df\nsdfsd'")
	testparse(parses)
	# testparse("var x = '\ntest\nhello\n'")

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