import * as util from './util'

import Compiler from './compiler'
import ImbaScript from './script'

let EDITING = no
global.state = {command: ''}

def isEditing
	global.state.command == 'updateOpen'


def stack state, cb
	let prev = global.state
	global.state = state
	let res = cb()
	global.state = prev
	return res	

export class Session
	
	def onMessage msg
		global.session = self
		#onMessage(msg)
		
	def toEvent name, body
		if global.state.formatEvent
			util.log('intercepting with formatEvent')
			body = global.state.formatEvent(name,body)
		#toEvent(name,body)
	
	def send msg
		util.log('send',msg)
		#send(msg)
		
	def refreshDiagnostics
		let files = Array.from(projectService.openFiles.keys!)
		let handler = handlers.get('geterr')
		let req = {arguments: {files: files, delay: 10}}
		util.log('sendErrors',req)
		handler.call(this,req)
	
	def parseMessage msg
		let res = #parseMessage(msg)
		if global.ils
			res = global.ils.rewriteInboundMessage(res)
		util.log('receive',res)
		return res
		
	def toFileSpan file, span, project
		
		let res = null
		if util.isImba(file)
			let script = project.getScriptInfo(file)
			let start = script.positionToLineOffset(span.start)
			let end =  script.positionToLineOffset(span.start + span.length)
			res = {
				file: file
				start: start
				end: end
			}
		else
			res = #toFileSpan(file,span,project)
			
		util.log('toFileSpan',file,span,res)
		return res
		
	def executeCommand request
		let res = stack(request) do #executeCommand(request)
		return res
		
	def filterDiagnostics file, project, diagnostics, kind
		let script = project.getScriptInfoForNormalizedPath(file)
		let state = {}
		
		# return diagnostics unless script.#imba
		
		for item in diagnostics
			try
				let mapper = item.file..scriptSnapshot..mapper
				continue unless mapper
				
				if item.#converted =? yes
					let mapper = item.file..scriptSnapshot..mapper
					item.#opos = [item.start,item.start + item.length]
					item.#mapper = [item.file,mapper]
					let range = mapper.o2dRange(item.start,item.start + item.length,no)
					# let start = mapper.o2d(item.start)
					# let end = mapper.o2d(item.start + item.length)
					if range.length
						item.start = range[0] or 0
						item.length = range[1] - range[0]
					else
						# hide the diagnostic if it doesnt map perfectly
						item.start = item.length = 0
						item.#suppress = yes
				
			catch e
				util.log('error',e)

		return diagnostics.filter do !$1.#suppress
			
	def sendDiagnosticsEvent(file, project, diags, kind)
		diags = filterDiagnostics(file,project,diags,kind)
		util.log('sendDiagnosticsEvent',file, project, diags, kind)
		#sendDiagnosticsEvent(file,project,diags,kind)
		
	def convertToDiagnosticsWithLinePosition diagnostics, script
		util.log 'convertToDiagnosticsWithLinePosition',diagnostics,script
		#convertToDiagnosticsWithLinePosition(diagnostics, script)

export class ScriptInfo
	
	get imbaContent
		#imba..content
	
	# mostly used by session to format diagnostics etc for vscode
	# default to convert to the imba offsets instead. It's important
	# to make sure diagnostics have converted the start,length props
	# to current imba coordinates before calling this
	def positionToLineOffset pos
		if #imba
			return #imba.positionToLineOffset(pos)

		let res = #positionToLineOffset(pos)
		return res
	
	# mostly called by session to convert from positions coming in from
	# vscode (ie. from the live imba file). Here we usually want the position
	# in the imba file - and then rather convert that to js when we want to.
	def lineOffsetToPosition line, offset, editable
		if #imba
			return #imba.lineOffsetToPosition(line, offset, editable)
		#lineOffsetToPosition(line,offset, editable)
		
	def o2d pos, source
		getMapper(source).o2d(pos)
			
	def d2o pos, source
		getMapper(source).d2o(pos)

	def jsPositionToImbaLineOffset pos
		let dpos = getMapper!.o2d(pos)
		#imba.svc.positionToLineOffset(dpos)
		
	def positionToImbaLineOffset offset
		let snap = getSnapshot!
		let converted = snap.c.o2i(offset)
		util.log('converted',path,offset,converted)
		let lo = snap.mapper.input.index.positionToLineOffset(converted)
		return lo
		
	def getMapper target
		let snap = target ? target.getSourceFile(path).scriptSnapshot : getSnapshot!
		return snap.mapper

	# imba position
	def imbaToJsPosition pos, program
		let mapper = getMapper(program)
		let ipos = mapper.d2i(pos)
		let opos = mapper.d2o(pos)
		util.log('rewind pos',pos,ipos,opos)

		return opos
		# let converted = snap.c.i2o(pos)

	
	
		
	def editContent start, end, newText
		util.log('editContent',start,end,newText)
		if #imba
			#imba.editContent(start,end,newText)
		else	
			#editContent(start,end,newText)
			
	def getSnapshot
		util.log('getSnapshot',self.path)
		#imba
		return #getSnapshot!
		

export class TextStorage
	
	# ts.server.ScriptVersionCache.fromString
	
	def getFileTextAndSize tempName
		if util.isImba(info.path)
			util.log('getFileTextAndSize',info.path,tempName,info.##imba)
			if #text != undefined
				return {text: #text}
			# info.im
			# should get the compilation connected
		#getFileTextAndSize(tempName)
	
	def smartReplaceText text
		# calculate edits by comparing current snapshot with content
		self

export class System
	def fileExists path
		if (/\.tsx$/).test(path)
			let ipath = path.replace('.tsx','.tsimba')
			return yes if #fileExists(ipath)
				
		return #fileExists(path)
	
	def readFile path,encoding = null
		const body = #readFile(...arguments)
		# if this is an imba file we want to compile it on the spot?
		# if the script doesnt already exist...
		if util.isImba(path)
			# first see if script exists?
			util.log("readFile",path)
			return Compiler.readFile(path,body)

		return body
		
export class Project
	def setCompilerOptions value
		let res = #setCompilerOptions(value)
		util.log('setCompilerOptions',this,value)
		return

		
export class ProjectService
	def getOrCreateOpenScriptInfo(fileName, fileContent, scriptKind, hasMixedContent, projectRootPath)
		let origFileContent = fileContent
		if util.isImba(fileName)
			util.log("getOrCreateOpenScriptInfo {fileName}",fileContent)
			# if fileContent !== undefined
			#	fileContent = Compiler.readFile(fileName,fileContent)

		let script = #getOrCreateOpenScriptInfo(fileName, fileContent, scriptKind, hasMixedContent, projectRootPath)
		
		script.#imba
		
		# if script.#imba and origFileContent !== undefined
		#	script.#imba.initWithContent(origFileContent)
			
		return script
		
export class ScriptVersionCache
	
	def getRawChangesBetweenVersions oldVersion, newVersion
		let edits = []
		while oldVersion < newVersion
			let snap = this.versions[++oldVersion]
			for edit of snap.changesSincePreviousVersion
				edits.push([edit.pos,edit.deleteLen,edit.insertedText or ''])
		
		return edits
		
	def smartReplaceText text
		# calculate edits by comparing current snapshot with content
		self
		
	def getRawChangesSince oldVersion = 0
		let snap = getSnapshot!
		getRawChangesBetweenVersions(oldVersion,snap.version)
			
	get syncedVersion
		getSnapshot!.version
			
	def getFullText
		let snap = getSnapshot!
		snap.getText(0,snap.getLength!)
		
	def getAdjustedOffset fromOffset, from, to = syncedVersion, stickyStart = no
		
		let minVersion = Math.min(from,to)
		let maxVersion = Math.max(from,to)
		
		let edits = getRawChangesBetweenVersions(minVersion,maxVersion)
		# console.log 'edits!!',edits,from,to

		let offset = fromOffset
		let modified = no
		
		if from < to
			for [start,len,text] in edits
				continue if start > offset
				start -= 1 if stickyStart
				if offset > start and offset > (start + len)
					offset += (text.length - len)
						
		elif to < from
			for [start,len,text] in edits.slice(0).reverse!
				continue if start > offset
				if offset > start and offset > (start + len)
					offset -= (text.length - len)

		return offset
		
	def rewindOffset offset, version
		getAdjustedOffset(offset,syncedVersion,version,yes)
	
	def forwardOffset offset, fromVersion
		getAdjustedOffset(offset,fromVersion,syncedVersion,yes)


export class TS
	def resolveModuleName moduleName, containingFile, compilerOptions, host, cache, redirectedReference
		let res = #resolveModuleName.apply(self,arguments)
		let hit = res..resolvedModule
		
		if hit..extension == '.tsx'
			let name = hit.resolvedFileName.replace('.tsx','.tsimba')
			if self.sys.fileExists(name)
				hit.resolvedFileName = name
				hit.extension = '.ts'

		return res
	
	def getScriptKindFromFileName fileName
		const ext = fileName.substr(fileName.lastIndexOf("."))
		return self.ScriptKind.JS if ext == '.tsimba'
		return #getScriptKindFromFileName(fileName)

export def subclasses ts
	let O = {}
	class O.ImbaScriptVersionCache < ts.server.ScriptVersionCache
		
		def currentVersionToIndex
			currentVersion
			
		def versionToIndex number
			number

	return O
	
export default def patcher ts
	util.extend(ts.server.Session.prototype,Session)
	util.extend(ts.server.ScriptInfo.prototype,ScriptInfo)
	util.extend(ts.server.TextStorage.prototype,TextStorage)
	util.extend(ts.server.ScriptVersionCache.prototype,ScriptVersionCache)
	util.extend(ts.server.ProjectService.prototype,ProjectService)
	util.extend(ts.server.Project.prototype,Project)
	util.extend(ts.sys,System)
	util.extend(ts,TS)
	
	let subs = subclasses(ts)
	
	for own k,v of subs
		ts[k] = v
	
	const SymbolObject = global.SymbolObject = ts.objectAllocator.getSymbolConstructor!
	const TypeObject   = global.TypeObject = ts.objectAllocator.getTypeConstructor!
	const NodeObject   = global.NodeObject = ts.objectAllocator.getNodeConstructor!
	const SourceFile   = global.SourceFile = ts.objectAllocator.getSourceFileConstructor!
	const Signature    = global.Signature = ts.objectAllocator.getSignatureConstructor!

	extend class SourceFile
			
		def i2o i
			scriptSnapshot.mapper.i2o(i)
			
		def d2i i
			scriptSnapshot.mapper.d2i(i)
		
		def d2o i
			scriptSnapshot.mapper.d2o(i)
			
		def o2d i
			scriptSnapshot.mapper.o2d(i)
			

	return ts
	
	