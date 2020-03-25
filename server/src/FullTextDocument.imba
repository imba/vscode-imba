import { Document } from './TextDocument'
import { TokenizedDocument } from './Parser'
import { Component } from './Component'

def computeLineOffsets text, isAtLineStart, textOffset
	if textOffset === undefined
		textOffset = 0

	var result = isAtLineStart ? [textOffset] : []
	var i = 0
	while i < text.length
		var ch = text.charCodeAt(i)
		if ch === 13 || ch === 10
			if ch === 13 && (i + 1 < text.length) && text.charCodeAt(i + 1) === 10
				i++
			result.push(textOffset + i + 1)
		i++
	return result

def getWellformedRange range
	var start = range.start
	var end = range.end
	if start.line > end.line || start.line === end.line && start.character > end.character
		return { start: end, end: start }
	return range

def getWellformedEdit textEdit
	var range = getWellformedRange(textEdit.range)
	if range !== textEdit.range
		return { newText: textEdit.newText, range: range }
	return textEdit

def mergeSort data, compare
	if data.length <= 1
		return data
	var p = (data.length / 2) | 0
	var left = data.slice(0, p)
	var right = data.slice(p)
	mergeSort(left, compare)
	mergeSort(right, compare)
	var leftIdx = 0
	var rightIdx = 0
	var i = 0
	while leftIdx < left.length && rightIdx < right.length
		var ret = compare(left[leftIdx], right[rightIdx])
		if ret <= 0
			// smaller_equal -> take left to preserve order
			data[i++] = left[leftIdx++]
		else
			// greater -> take right
			data[i++] = right[rightIdx++]

	while (leftIdx < left.length)
		data[i++] = left[leftIdx++]

	while (rightIdx < right.length)
		data[i++] = right[rightIdx++]

	return data

var documentCache = {}

export class FullTextDocument < Component

	static def create uri, languageId, version, content
		return self.new(uri,languageId,version,content)

	static def update document, changes, version
		document.update(changes,version)
		return document

	static def applyEdits document,edits
		self

	def constructor uri, languageId, version, content
		super
		uri = uri
		languageId = languageId
		version = version
		content = content
		cache = {}

		if languageId == 'imba'
			tokens = TokenizedDocument.new(self)

	get lineCount
		lineOffsets.length

	get lineOffsets
		_lineOffsets ||= computeLineOffsets(content,yes)
	
	def getText range = null
		if range
			var start = offsetAt(range.start)
			var end = offsetAt(range.end)
			return content.substring(start, end)
		return content
	
	def positionAt offset
		offset = Math.max(Math.min(offset, content.length), 0)
		var lineOffsets = lineOffsets
		var low = 0
		var high = lineOffsets.length
		if high === 0
			return { line: 0, character: offset }
		while low < high
			var mid = Math.floor((low + high) / 2)
			if lineOffsets[mid] > offset
				high = mid
			else
				low = mid + 1
		// low is the least x for which the line offset is larger than the current offset
		// or array.length if no line offset is larger than the current offset
		var line = low - 1
		return { line: line, character: (offset - lineOffsets[line]) }

	def offsetAt position
		if position.offset
			return position.offset

		var lineOffsets = lineOffsets
		if position.line >= lineOffsets.length
			return content.length
		elif position.line < 0
			return 0

		var lineOffset = lineOffsets[position.line]
		var nextLineOffset = (position.line + 1 < lineOffsets.length) ? lineOffsets[position.line + 1] : content.length
		return Math.max(Math.min(lineOffset + position.character, nextLineOffset), lineOffset)

	def overwrite body
		version++
		content = body
		_lineOffsets = null
		if tokens
			tokens.invalidateFromLine(0)
		return self

	def update changes, version
		# what if it is a full updaate
		# handle specific smaller changes in an optimized fashion
		# many changes will be a single character etc
		for change,i in changes
			var range = getWellformedRange(change.range)
			var startOffset = offsetAt(range.start)
			var endOffset = offsetAt(range.end)
			change.range = range
			change.offset = startOffset
			change.length = endOffset - startOffset
			range.start.offset = startOffset
			range.end.offset = endOffset
			# console.log 'update',startOffset,endOffset,change.text,JSON.stringify(content)
			# content = content.substring(0, startOffset) + change.text + content.substring(endOffset, content.length)
			applyEdit(change,version,changes)

			var startLine = Math.max(range.start.line, 0)
			var endLine = Math.max(range.end.line, 0)
			var lineOffsets = _lineOffsets

			# many items has no line offset changes at all?

			var addedLineOffsets = computeLineOffsets(change.text, false, startOffset)

			if (endLine - startLine) === addedLineOffsets.length
				for added,k in addedLineOffsets
					lineOffsets[k + startLine + 1] = addedLineOffsets[i]
			else
				if addedLineOffsets.length < 10000
					lineOffsets.splice.apply(lineOffsets, [startLine + 1, endLine - startLine].concat(addedLineOffsets))
				else
					_lineOffsets = lineOffsets = lineOffsets.slice(0, startLine + 1).concat(addedLineOffsets, lineOffsets.slice(endLine + 1))

			var diff = change.text.length - (endOffset - startOffset)
			if diff !== 0
				let k = startLine + 1 + addedLineOffsets.length
				while k < lineOffsets.length
					lineOffsets[k] = lineOffsets[k] + diff
					k++
		
		updated(changes,version)

	def updated changes,version
		version = version
		self

	def applyEdit change, version, changes
		content = content.substring(0, change.range.start.offset) + change.text + content.substring(change.range.end.offset, content.length)
		tokens.applyEdit(change,version,changes) if tokens

	def getContextAtOffset offset
		self


export class ImbaTextDocument < FullTextDocument

	def constructor ...params
		super