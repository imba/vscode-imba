# extend scriptInfo
import fs from 'fs'
import * as util from './util'

import { TokenModifier, TokenType } from './constants'
import Compiler from './compiler'

import { ImbaDocument } from '../document'
import ImbaScriptInfo from '../document/snapshot'

export default class ImbaScript
	constructor info
		self.info = info

		if info.scriptKind == 0
			info.scriptKind = 1
			util.log("had to wake script {fileName}")
			
			
	def getMapper target
		let snap = target ? target.getSourceFile(fileName).scriptSnapshot : info.getSnapshot!
		return snap.mapper
	
	def o2d pos, source
		getMapper(source).o2d(pos)
			
	def d2o pos, source
		getMapper(source).d2o(pos)

	def setup
		util.log("setup {fileName}",info.textStorage.text)	
		let orig = info.textStorage.text
		if orig == undefined
			orig = fs.readFileSync(fileName,'utf-8')

		svc = TS.server.ScriptVersionCache.fromString(orig or '')
		svc.currentVersionToIndex = do this.currentVersion
		svc.versionToIndex = do(number) number
		doc = new ImbaScriptInfo(svc)
		
		# now do the initial compilation?
		let result = compile!
		let its = info.textStorage
		let snap = its.svc = TS.server.ScriptVersionCache.fromString(result.js or '\n')
		its.text = undefined
		its.reload = do(newText)
			util.log('reload',fileName,newText)
			return false

		snap.getSnapshot!.mapper = result
		return self
		
	def lineOffsetToPosition line, offset, editable
		svc.lineOffsetToPosition(line, offset, editable)
		
	def positionToLineOffset pos
		svc.positionToLineOffset(pos)

	def asyncCompile
		util.log('async compile!')
		let snap = svc.getSnapshot!
		let body = snap.getText(0,snap.getLength!)
		let output = Compiler.compile(info,body)
		output.input = snap
		sa
		if output.js
			applyOutput(output)
	
	def applyOutput result
		let its = info.textStorage
		let end = its.svc.getSnapshot!.getLength!
		util.log('apply output!',result.js,end,its)
		its.edit(0, end, result.js)
		let snap = its.svc.getSnapshot!
		snap.mapper = result
		info.markContainingProjectsAsDirty!
		# probably dont want to do this while editing all the time?
		global.session.refreshDiagnostics!

	def editContent start, end, newText
		svc.edit(start,end - start,newText)
		util.delay(self,'asyncCompile',200)

	def compile
		let snap = svc.getSnapshot!
		let body = snap.getText(0,snap.getLength!)
		let result = Compiler.compile(info,body)
		result.input = snap
		return result		
		
	get snapshot
		svc.getSnapshot!
	
	get content
		let snap = svc.getSnapshot!
		return snap.getText(0,snap.getLength!)
			
	# get doc
	# 	#doc ||= new ImbaDocument(info.path,'imba',0,contentOnDisk)
	
	get fileName
		info.path
		
	def wake
		yes
		
	def jsToImbaPosition pos, compiledVersion
		# need to know the version for this?
		self

	def getSemanticTokens
		let result\number[] = []
		let typeOffset = 8
		let modMask = (1 << typeOffset) - 1
		
		for tok,i in doc.tokens when tok.symbol
			let sym = tok.symbol
			let typ = TokenType.variable
			let mod = 0
			let kind = sym.semanticKind
			if TokenType[kind] != undefined
				typ = TokenType[kind]
				
			if sym.global?
				mod |= 1 << TokenModifier.defaultLibrary
			
			if sym.static?
				mod |= 1 << TokenModifier.static
			
			if sym.imported?
				typ = TokenType.namespace

			result.push(tok.offset, tok.endOffset - tok.offset, ((typ + 1) << typeOffset) + mod)
		
		# util.log("semantic!",result)
		return result		