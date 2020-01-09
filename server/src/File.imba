var ts = require 'typescript'

var imbac = require 'imba/dist/compiler.js'
var sm = require "source-map"

var imbaOptions = {
	target: 'node'
	imbaPath: null
	sourceMap: {}
}

export class File
	def constructor program, path
		console.log "created file {path}"
		@program = program
		@jsPath = path.replace(/\.imba$/,'.js')
		@imbaPath = path.replace(/\.js$/,'.imba')
		@version = 1

	get document
		let uri = 'file://' + @imbaPath
		console.log "get {uri}"
		@program.documents.get(uri)

	def didChange doc
		console.log 'did change!',@version,doc.version
		if doc.version != @version
			@version = doc.version
			@content = doc.getText()
			@invalidate()
			@emit()

	def emit
		@ls.getEmitOutput(@jsPath)


	def positionAt offset
		let loc = @locs and @locs.map[offset]
		return loc && {line: loc[0], character: loc[1]}
		# @document && @document.positionAt(offset)

	def offsetAt position
		@document && @document.offsetAt(position)

	# remove compiled output etc
	def invalidate
		@result = null
		self

	get ls
		@program.service

	get uri
		'file://' + @imbaPath

	def compile
		unless @result
			var body = @content or ts.sys.readFile(@imbaPath)
			var res = imbac.compile(body,imbaOptions)
			@result = res
			# @sourcemap = sm.SourceMapConsumer.new(res.sourcemap)
			@locs = res.locs
			@js = res.js # .replace('$CARET$','')
		return self

	def originalLocFor loc
		let locs = @locs.generated
		for [jloc,iloc],i in locs
			if jloc > loc
				let pos = locs[i - 1]
				return pos and pos[1]
		return null

	def generatedLocFor loc
		let locs = @locs.generated
		for [jloc,iloc],i in locs
			let prev = locs[i - 1]
			let next = locs[i + 1]

			if loc >= iloc and (!next or next[1] >= loc)
				console.log "found generated loc",loc,[jloc,iloc],next,jloc + (loc - iloc)
				return jloc + (loc - iloc)
		return null

	# def originalPositionFor pos
	# 	@compile()
	# 	console.log 'originalPositionFor',pos
	# 	@sourcemap.originalPositionFor(pos)

	# def generatedPositionFor pos
	# 	@compile()
	# 	pos.column ||= pos.character
	# 	@sourcemap.generatedPositionFor(pos)

	def originalSpanFor span
		return unless span
		let start = @originalLocFor(span.start)
		let end = @originalLocFor(span.start + span.length)
		return {
			start: start
			length: end - start
			range: {start: @positionAt(start), end: @positionAt(end)}
		}

	def locToRange
		{start: @document.positionAt(loc[0]), end: @document.positionAt(loc[1])}

	def textSpanToRange span
		let start = @originalLocFor(span.start)
		let end = @originalLocFor(span.start + span.length)
		{start: @positionAt(start), end: @positionAt(end)}

	def originalDocumentSpanFor orig
		let res = {
			fileName: @imbaPath
			textSpan: @originalSpanFor(orig.textSpan)
			contextSpan: @originalSpanFor(orig.contextSpan)
		}
		console.log('converted',orig,res,@locmap)
		# orig.converted = res
		# orig.locmap = @locmap

		for own k,v of res
			orig[k+'Orig'] = orig[k]
			orig[k] = v

		# if false
		# 	orig.fileName = @imbaPath
		# 	orig.textSpan && (orig.textSpan = @originalSpanFor(orig.textSpan))
		# 	orig.contextSpan && (orig.contextSpan = @originalSpanFor(orig.contextSpan))
		return orig

	def getDefinitionAtPosition loc
		# autoconvert between location and other?
		let res = @ls.getDefinitionAtPosition(@jsPath, @generatedLocFor(loc))
		return @program.rewriteDefinitions(res)

	def getQuickInfoAtPosition loc
		@ls.getQuickInfoAtPosition(@jsPath, @generatedLocFor(loc))

