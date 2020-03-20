var content = `<div.one.two title=10 :click.test>`
import {File} from './File'
import {LanguageServer} from './LanguageServer'
import * as util from './utils'

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
			console.log file.getContextAtLoc(pos)

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

if true
	let file = ls.getImbaFile('completion.imba')
	let content = file.getSourceContent()
	let last = 0
	let idx = 0
	while (idx = content.indexOf('# |',last)) > -1
		last = idx + 2
		if let m = content.slice(idx + 3).match(/^\d+/)
			idx = idx - parseInt(m[0])

		console.log 'found index',idx
		console.dir file.getContextAtLoc(idx), {depth: 7}
		# let completions = ls.getCompletionsAtPosition(file.uri,idx,{})
		# console.log completions

	if false
		console.log file.getContextAtLoc(301)
		console.dir file.getSymbols(), { depth: 6 }
		console.log file.textSpanToRange({ start: 229, length: 11 })
		console.log util.fastExtractSymbols(content)
	
	toffset2ioffset(file,21,0)
	toffset2ioffset(file,32,0)
	toffset2ioffset(file,51,0)
	

	# console.log file.$decorations

	# console.log ls.getCompletionsAtPosition('completion.imba',89)
if false
	console.log util.fastParseCode('<div hello=(')
	console.log util.fastParseCode('<div> "')
	console.log util.fastParseCode('<div> "{')
	console.log util.fastParseCode('<div.{')
	console.log util.fastParseCode('<div test=')
	console.log util.fastParseCode('<div v=({')
	console.log util.fastParseCode('<div> <','>')
# ls.getCompletionsAtPosition('completion.imba',88)
# console.log ls.getImbaFile('completion.imba').getContextAtLoc(89)
# ls.emitDiagnostics()