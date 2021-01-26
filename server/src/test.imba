let content = `<div.one.two title=10 :click.test>`
# import {inspect} from 'util'
import {File} from './File'
import {LanguageServer} from './LanguageServer'
import * as util from './utils'
import { FullTextDocument } from './FullTextDocument'
import * as ts from 'typescript'
import * as fs from 'fs'
import * as svg from './StylePreviews'

let imbac = require 'imba/dist/compiler.js'


let conn = {
	sendDiagnostics: do yes
}

def toffset2ioffset file, start, length
	let iloc = file.originalLocFor(start)
	let range = file.textSpanToRange({ start: start, length: length })
	console.log "orig offset",start,length,iloc,range

def log ...params
	console.log(...params)

def time blk
	let t = Date.now!
	let res = blk()
	console.log 'time',Date.now! - t
	return res

def inspect item
	console.log item.escapedName, item.flags
	console.dir item, depth: 1
	if item.declarations
		console.dir item.declarations, depth: 1
	try
		console.dir item.valueDeclaration.name, depth: 1
		console.dir item.valueDeclaration.members, depth: 1
		console.dir item.valueDeclaration.locals, depth: 1
	
	# if item.flowNode
	#	console.dir item.flowNode, depth: 1

def lprops props, key
	console.log "---- properties"
	for item in props
		if key
			console.log item[key]
			continue

		if item.label
			console.log item.label
			continue

		let pr = item.parent..escapedName
		# console.log item.escapedName
		console.log item.escapedName,pr
	console.log "\n"

console.log svg.easing('ease')
console.log svg.easing('circ-out')
console.log svg.uri(svg.easing('ease'))

if true
	let content = fs.readFileSync('/Users/sindre/repos/vscode-imba/test/one.imba1','utf8')
	let symbols = util.fastExtractSymbols(content)
	let logsym = do(sym)
		console.log sym.kind,sym.name,sym.span
		for item in sym.children
			logsym(item)

	logsym(symbols)
	# console.log symbols

if false
	let rootFile = '/Users/sindre/repos/vscode-imba/test/main.ts'
	let ls = new LanguageServer(conn,null,{
		rootUri: 'file:///Users/sindre/repos/vscode-imba/test'
		rootFiles: []
		debug: true
	})
	ls.start({})
	let ifile = ls.addFile(rootFile)
	ls.emitRootFiles!
	let t0 = Date.now!
	let prog = ls.tls.getProgram!
	let files = prog.getSourceFiles!
	let checker = prog.getTypeChecker!
	let file = prog.getSourceFile(rootFile)
	# log file

	let iloc = do(iloc)
		if typeof iloc == 'string'
			let index = ifile.doc.getText!.lastIndexOf(iloc)
			if index >= 0
				iloc = index + iloc.length
		return iloc

	let tstokat = do(iloc,offset = 0)
		if typeof iloc == 'string'
			let index = ifile.doc.getText!.lastIndexOf(iloc)
			if index >= 0
				iloc = index + iloc.length + offset

		ifile.emitFile!
		ts.findPrecedingToken(ifile.generatedLocFor(iloc),file)
	
	let access = do(type,key)
		let sym = type.getProperty(key)
		return checker.getTypeOfSymbolAtLocation(sym,file)

	let insplocal = do(name,access)
		let sym = file.locals.get(name)
		let type = checker.getTypeOfSymbolAtLocation(sym,file)
		
		if access
			for key in access
				let sym = type.getProperty(key)
				if sym
					console.log 'found access sym',sym
					type = checker.getTypeOfSymbolAtLocation(sym,file)
		
		lprops type.getProperties!
	
	let insploc = do(iloc,access)
		let tok = tstokat(iloc)
		let orig = tok
		# log tok

		if tok and tok.kind == 24
			tok = tok.parent.expression

		let sym = checker.getSymbolAtLocation(tok)
		# log sym
		# log checker.getExportSymbolOfSymbol(sym)
		let type = checker.getTypeOfSymbolAtLocation(sym,orig)
		
		# log type
		log "inspected loc {iloc}"
		lprops type.getApparentProperties!

		if access
			let typ = type
			for key in access
				let sym = typ.getProperty(key)
				if sym
					console.log 'found access sym',sym
					typ = checker.getTypeOfSymbolAtLocation(sym,file)
			
			lprops typ.getProperties!

	if true
		log file
		# inspect file.locals.get('MyArray')
		# inspect file.locals.get('obj')
		# inspect file.locals.get('obj2')
		# inspect file.locals.get('arr')
		# inspect tstokat('arr =',-2)
		# inspect tstokat('arr3')
		# inspect file.locals.get('arr3')
		inspect file.locals.get('func1')

		let t1 = tstokat('one,',-1)
		let t2 = tstokat('one +',-2) 
		let t3 = tstokat('three =',-2) 
		let s1 = checker.getSymbolAtLocation(t1)
		let s2 = checker.getSymbolAtLocation(t2)
		inspect t1
		inspect t2
		inspect t3
		log s1
		log s2
		log s1 == s2

	if false
		# insploc(696)
		# insploc(726) # arr (List)
		# insploc(643) # arr (List)
		# insploc(739) # List class name
		# insploc(878,['storage']) # instance.items
		# insplocal('List',['prototype'])
		# log ifile.getSelfAtOffset(256)
		# log tstokat(92)
		# log tstokat(105)
		ls.emitDiagnostics!

		log insploc('HELLO')
		log insploc('LOCAL')
		
		
		let files = ls.getProgram!.getSourceFiles!
		for item in files
			if item.fileName.match(/check/)
				console.dir item, depth: 0
		
		for item in files
			console.log item.fileName

		log insploc('CompletionTypes')
		log insploc('console')


		lprops ifile.getCompletionsAtOffset(iloc('console.'))
		lprops ifile.getCompletionsAtOffset(iloc('CompletionTypes.'))
		# lprops ls.getProgram!.getSourceFiles!, 'fileName'
		# log file
		# log insploc(105)
		# lprops ifile.getCompletionsAtOffset(92)

		# lprops ifile.getCompletionsAtOffset(879)
		# lprops time do type.getProperties!
		# lprops access(type,'console').getProperties!
		# log file
		# let glob = checker.resolveName('globalThis',undefined,ts.SymbolFlags.Value,false)
		# let type = checker.getTypeOfSymbolAtLocation(glob,file)
		# lprops type.getApparentProperties!
		# log type.getProperty('"assert"')
		# lprops insploc(909,['call'])
		# lprops insploc(927)


	if false
		let $self = ifile.getSelfAtOffset(545)
		# console.log $self.properties[1]
		# console.log ifile.getCompletionsAtOffset(545).map(do $1.label) # members
		# console.log ifile.getCompletionsAtOffset(574).map(do $1.label) # static
		let $member = ifile.findSymbol('MyArray#again')
		let $static = ifile.findSymbol('MyArray.create')
		console.dir $member.symbol, depth: 1
		console.dir $member.type, depth: 1
		console.dir $member.type.resolvedBaseConstructorType, depth: 1
		console.dir $member.thisType, depth: 1
		# console.dir $static, depth: 1
		# console.dir $static.resolvedBaseConstructorType, depth: 1
		# console.log ifile.findSymbol('MyArray.create').type.properties.slice(0,1)
		

	if false
		# Array.from(undefined,10)
		let file = ls.getImbaFile('completion.imba')
		let compiled-offset = file.generatedLocFor(54)
		console.log "hello",compiled-offset
		let res = ls.tls.getCompletionsAtPosition(file.tsPath,compiled-offset,{
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
		

let tmpdoc = new FullTextDocument('','imba',0,'')

def testparse code
	return
	console.log "\nparsing ---"
	console.log code

	let locs = []

	while code.indexOf('§') >= 0
		locs.push(code.indexOf('§'))
		code = code.replace(/§/,'')

	tmpdoc.overwrite(code)

	# console.log 'get tmpdoc tokens',tmpdoc.content
	
	let tokens = tmpdoc.tokens.parse!
	let prevstack = ""
	for tok in tokens
		let stacks = []
		let part = tok.stack
		while part
			stacks.unshift(part.state)
			part = part.parent

		let stack = stacks.join('>')
		stack = stacks[stacks.length - 1]

		if stack != prevstack
			prevstack = stack
		else
			stack = ''
		if tok.type == 'white'
			continue

		console.log [tok.offset,tok.value,tok.type,stack]

	for offset in locs
		let ctx = tmpdoc.tokens.getContextAtOffset(offset)
		# ctx.vars = ctx.vars.map do $1.value
		# for own k,v of ctx
		#	if v and v.language == 'imba'
		#		ctx[k] = [v.offset,v.value,v.type]
		console.log [ctx.mode]

testparse(`
css div
	d:flex
	d:flex m.§

css .box
	bg:white .blue:1

yes
`)