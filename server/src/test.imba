var content = `<div.one.two title=10 :click.test>`
import {File} from './File'
import {LanguageServer} from './LanguageServer'

var tests = [
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
	ls.updateFile('component.imba') do |content| content.replace(/@titl\b/,'@titls')
	ls.getSemanticDiagnostics()
	ls.updateFile('component.imba') do |content| content.replace(/@titls\b/,'@titl')
	ls.getSemanticDiagnostics()
	ls.inspectProgram()
	# ls.inspectFile('data.js')
	# ls.removeFile('data.imba')
	ls.getSemanticDiagnostics()
	console.log ls.getSymbols('util.imba')
# console.log ls.getCompletionsAtPosition('util.imba',184,jsLoc: 215)
# console.log ls.getCompletionsAtPosition('util.imba',184)
# console.log
console.log ls.getCompletionsAtPosition('completion.imba',89)
# ls.getCompletionsAtPosition('completion.imba',88)
# console.log ls.getImbaFile('completion.imba').getContextAtLoc(89)
# ls.emitDiagnostics()