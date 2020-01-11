import {CompletionItemKind,DiagnosticSeverity} from 'vscode-languageserver-types'

var ts = require 'typescript'

var imbac = require 'imba/dist/compiler.js'
var sm = require "source-map"

var imbaOptions = {
	target: 'tsc'
	imbaPath: null
	sourceMap: {}
}

export class File
	def constructor program, path
		console.log "created file {path}"
		@program = program
		@jsPath = path.replace(/\.imba$/,'.js')
		@imbaPath = path.replace(/\.js$/,'.imba')
		# @registry = program.registry
		@version = 1
		@diagnostics = []
		@invalidate()

		unless program.rootFiles.includes(@jsPath)
			program.files[@jsPath] = self
			program.files[@imbaPath] = self
			program.rootFiles.push(@jsPath)
			program.version++
			let snapshot = ts.ScriptSnapshot.fromString("")
			@jsDoc = program.acquireDocument(@jsPath,snapshot,@version)
			@ls.getEmitOutput(@jsPath)
			@emit()
		self


	get document
		let uri = 'file://' + @imbaPath
		console.log "get {uri}"
		@program.documents.get(uri)

	get ls
		@program.service

	get uri
		'file://' + @imbaPath

	def didChange doc
		@doc = doc
		if doc.version != @version
			console.log 'did change!',@version,doc.version
			@version = doc.version
			@content = doc.getText()
			@dirty = yes
			@program.version++
			@invalidate()
			@compile()
			

	def didSave doc
		@content = doc.getText()
		# if @dirty
		# 	@dirty = no
		@program.version++
		@invalidate()
		@ls.getEmitOutput(@jsPath)
		

	def emitFile
		@ls.getEmitOutput(@jsPath)

	def emit
		self


	def emitDiagnostics
		var diagnostics = @ls.getSemanticDiagnostics(@jsPath)
		if diagnostics and diagnostics.length
			@diagnostics = diagnostics.map do |entry|
				let lstart = @originalLocFor(entry.start)
				# console.log 'converting diagnostic',entry,lstart
				return {
					severity: DiagnosticSeverity.Warning
					message: entry.messageText.messageText or entry.messageText
					range: {
						start: @positionAt(lstart)
						end: @positionAt(@originalLocFor(entry.start + entry.length) or (lstart + entry.length))
					}
				}
			console.log "ts diagnostics",@diagnostics.map do [$1.severity,$1.message,$1.range.start,$1.range.end]
			@sendDiagnostics()
		else
			# @diagnostics.length
			# just remove the ts-related diagnostics
			@diagnostics = []
			@sendDiagnostics()

	def updateDiagnostics entries, group
		self

	def sendDiagnostics
		# console.log "sending diagnostics",@diagnostics.map do [$1.severity,$1.message,$1.range.start,$1.range.end]
		@program.connection.sendDiagnostics(uri: @uri, diagnostics: @diagnostics)

	def positionAt offset
		if @doc
			return @doc.positionAt(offset)

		let loc = @locs and @locs.map[offset]
		return loc && {line: loc[0], character: loc[1]}
		# @document && @document.positionAt(offset)

	def offsetAt position
		@document && @document.offsetAt(position)

	# remove compiled output etc
	def invalidate
		@result = null
		@cache = {
			srclocs: {}
			genlocs: {}

		}
		self

	def compile
		unless @result
			var body = @content or ts.sys.readFile(@imbaPath)
			try
				var res = imbac.compile(body,imbaOptions)
			catch e
				let loc = e.loc && e.loc()
				let range = loc && {
					start: @positionAt(loc[0])
					end: @positionAt(loc[1])
				}

				let err = {
					severity: DiagnosticSeverity.Error
					message: e.message
					range: range
				}
				# console.log 'compile error',err
				@diagnostics = [err]
				@sendDiagnostics()
				@result = {error: err}
				return self

			@result = res
			@locs = res.locs
			@js = res.js.replace('$CARET$','valueOf')
			setTimeout(&,0) do @emitDiagnostics()
		return self

	def originalRangesFor jsloc
		@locs.spans.filter do |pair|
			jsloc >= pair[0] and pair[1] >= jsloc

	# need a better converter
	def originalLocFor jsloc
		let val = @cache.srclocs[jsloc]
		if val != undefined
			return val

		let spans = @originalRangesFor(jsloc)
		let val
		if let span = spans[0]
			let into = (jsloc - span[0]) / (span[1] - span[0])
			let offset = Math.floor(into * (span[3] - span[2]))
			# console.log 'found originalLocFor',jsloc,spans
			if span[0] == jsloc
				val = span[2]
			elif span[1] == jsloc
				val = span[3]
			else
				val = span[2] + offset

		return @cache.srclocs[jsloc] = val

	def generatedRangesFor loc
		@locs.spans.filter do |pair|
			loc >= pair[2] and pair[3] >= loc

	def generatedLocFor loc
		let spans = @generatedRangesFor(loc)
		if let span = spans[0]
			let into = (loc - span[2]) / (span[3] - span[2])
			let offset = Math.floor(into * (span[1] - span[0]))
			# console.log 'found generatedLocFor',loc,spans
			if loc == span[2]
				return span[0]
			elif loc == span[3]
				return span[1]
			else
				return span[0] + offset
		return null

	def textSpanToRange span
		let start = @originalLocFor(span.start,0)
		let end = @originalLocFor(span.start + span.length)
		# console.log 'textSpanToRange',span,start,end,@locs and @locs.generated
		{start: @positionAt(start), end: @positionAt(end)}
