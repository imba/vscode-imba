import {DiagnosticSeverity} from 'vscode-languageserver-types'
import * as config from './Config'

export const DiagnosticSource = {
	Compiler: 1
	TypeScript: 2
	Monarch: 3
}

export const DiagnosticKind = {
	Compiler: 1 << 0
	TypeScript: 1 << 2
	Monarch: 1 << 3
	Semantic: 1 << 4
	Syntactic: 1 << 5
}

const WARN = DiagnosticSeverity.Warning
const ERR = DiagnosticSeverity.Error
const INFO = DiagnosticSeverity.Information

export const ImbaSeverityToLSP = {
	error: ERR
	warning: WARN
	info: INFO
}

# https://github.com/microsoft/TypeScript/blob/master/src/compiler/diagnosticMessages.json
# message: /Type '-?[\d\.]+' is not assignable to type 'string'/
# ideally only for a

const SuppressDiagnostics = [
	
	code: 2322	
	text: /^\$\d+/
	---
	code: 2322 # should only be for dom nodes?
	message: /^Type '(boolean|string|number|ImbaAsset|typeof import\("data:text\/asset;\*"\))' is not assignable to type '(string|number|boolean)'/
	---
	code: 2339
	message: /on type 'EventTarget'/
	---
	code: 2339
	message: /\$CARET\$/
	---
	code: 2339
	message: /Property '_\$SYM\$/
	---
	code: 2339 # option allow array properties
	message: /on type '(.*)\[\]'/
	---
	code: 2339 # option allow array properties
	message: /on type 'Window'/
	---
	code: 2339 # option allow array properties
	message: /on type 'Window & typeof globalThis'/
	---
	code: 2556
	text: /\.\.\.arguments/
	---
	code: 2540 # should be toggled with option
	message: /^Cannot assign to /
	---
	code: 2557
	text: /\.\.\.arguments/
	---
	code: 2554
	test: do({message})
		return no unless typeof message == 'string'
		let m = message.match(/Expected (\d+) arguments, but got (\d+)/)
		return yes if m and parseInt(m[1]) > parseInt(m[2])
		return no
	---
	code: 2339 # should we always?
	message: /on type '\{\}'/
	---
	code: 2304 # dynamic asset items
	message: /Svg[A-Z]/
	---
	code: 2538 # dynamic asset items
	message: /unique symbol' cannot be used as an index type/
]

export class Diagnostic

	static def fromCompiler kind, entry, doc
		return entry

	static def fromTypeScript kind, entry, doc, options = {}
		let file = entry.file
		let msg = entry.messageText
		msg = msg.messageText or msg or ''
		let sev = [WARN,ERR,INFO,INFO][entry.category]
		let rawCode = file.text.substr(entry.start,entry.length)
		let rawExpandedCode = file.text.substr(entry.start - 10,entry.length + 10)

		for rule in SuppressDiagnostics
			if rule.code == entry.code
				if rule.text isa RegExp
					if rule.text.test(rawCode)
						return 
				if rule.message isa RegExp
					return if rule.message.test(msg)
				if rule.test isa Function
					return if rule.test({message: msg, text: rawCode})

		if options.suppress
			for rule in options.suppress
				return if rule.test(msg)

		let range = doc.sourceRangeAt(entry.start,entry.start + entry.length)

		unless range
			let lstart = doc.originalLocFor(entry.start)
			let lend = doc.originalLocFor(entry.start + entry.length) or (lstart + entry.length)
			
			let start = doc.positionAt(lstart)
			let end = doc.positionAt(lend)
			
			range = doc.rangeAt(lstart,lend)
			range.#lstart = lstart
			range.#lend = lend


		if msg.match('does not exist on type')
			sev = WARN

		if !range or Number.isNaN(range.start.character)
			return null

		# if config.get('verbose')
		#	msg += " | " + JSON.stringify([rawCode,entry.code,entry.start,entry.length,rawExpandedCode,range])
		#
		#	if msg.indexOf('sys$1') >= 0
		#		msg += '\n' + file.text

		# console.log "ts diagnostic",entry.code,entry.start,entry.length,rawCode,range,entry.messageText
		
		return new Diagnostic({
			severity: sev
			message: msg.messageText or msg
			range: range
			data: {
				kind: kind
				version: doc.version
			}
		})

	def constructor {severity,message,range,data}
		self.severity = severity
		self.message = message
		self.range = range
		self.data = data


export class Diagnostics
	def constructor doc
		self.doc = doc
		self.all = []
		self.dirty = no
	
	def update kind, items, versions = null
		dirty = yes
		all = all.filter do $1.data.kind != kind

		if kind & DiagnosticKind.TypeScript
			let options = {suppress: []}
			let customRules = doc.program.imbaConfig..diagnostics..suppressErrorRules
			if customRules isa Array
				for item in customRules
					if typeof item == 'string'
						options.suppress.push(new RegExp(item))
			#tsDiagnostics = items
			items = items.map do Diagnostic.fromTypeScript(kind,$1,doc,options)
			items = items.filter do $1
			
		let text = doc.doc.getText! # .slice(lstart,lstart + entry.length)

		for item in items
			item.data ||= {}
			item.data.kind ||= kind
			item.data.version = doc.version
			if item.range
				item.data.text ||= text.substr(item.range.offset,item.range.length)
		# console.log 'update diagnostics',kind,items
		all = all.concat(items)
		sync!
		self

	def clear kind = 0
		# all = all.filter do $1.data.kind != kind
		all = []
		sync yes

	def log ... params
		if doc.logLevel > 0
			console.log(...params)

	def syncItem item,version
		let range = item.range
		let meta = item.data

		if meta.version != version and range
			let start0 = range.offset
			let end0 = start0 + range.length

			let start1 = doc.idoc.offsetAtVersion(start0,meta.version)
			let end1 = doc.idoc.offsetAtVersion(end0,meta.version)

			log('syncItem',start0,end0,start1,end1,version)

			if start0 != start1 or end1 != end0
				console.log 'syncing version',start0,end0,start1,end1,version
				self.dirty = yes

			item.range = doc.rangeAt(start1,end1)
			
			# {
			#	offset: start1
			# 	length: end1 - start1
			# }

			let text = doc.doc.getText!.slice(start1,end1)

			if text != meta.text
				log 'text content of diagnostic range changed',meta.text,text
				meta.text = text
				item.remove = yes
				self.dirty = yes

			item.data.version = version

		return item

	def sync force = no
		let version = doc.idoc.version
		for item in all
			syncItem(item,version)

		if dirty or force
			send!
		self

	def send
		dirty = no
		all = all.filter do !$1.remove
		# if all.length
		#	console.log 'send diagnostics',all
		# for item in all
		#	if let range = item.range
		#		range.start = doc.idoc.positionAt(range.offset)
		#		range.end = doc.idoc.positionAt(range.offset + range.length)
		log 'sending',all
		doc.program.connection.sendDiagnostics(uri: doc.uri, diagnostics: all)
