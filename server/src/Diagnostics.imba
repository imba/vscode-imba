import {DiagnosticSeverity} from 'vscode-languageserver-types'

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

export class Diagnostic

	static def fromTypeScript kind, entry, doc
		let file = entry.file
		let msg = entry.messageText
		let sev = [WARN,ERR,INFO,INFO][entry.category]

		let rawCode = file.text.substr(entry.start,entry.length)
		let lstart = doc.originalLocFor(entry.start)
		let lend = doc.originalLocFor(entry.start + entry.length) or (lstart + entry.length)
		let imbaCode = doc.doc.getText!.slice(lstart,lstart + entry.length)
		
		let start = doc.positionAt(lstart)
		let end = doc.positionAt(lend)
		
		let range = {
			offset: lstart
			length: lend - lstart
			start: doc.positionAt(lstart)
			end: doc.positionAt(lend)

		}
		return new Diagnostic({
			severity: sev
			message: msg.messageText or msg
			range: range
			data: {
				kind: kind
				version: doc.version
				text: imbaCode
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
		all = all.filter do $1.data.kind != kind

		if kind & DiagnosticKind.TypeScript
			items = items.map do Diagnostic.fromTypeScript(kind,$1,doc)
			log 'converting diagnostics',items

		all = all.concat(items)
		send!
		self

	def clear kind = 0
		# all = all.filter do $1.data.kind != kind
		all = []
		send!

	def onDidChangeContent event
		log 'sync diagnostics after update',doc.version,doc.idoc.version
		sync!
		self

	def log ... params
		if doc.logLevel > 0
			console.log(...params)

	def syncItem item,version
		let start0 = item.range.offset
		let end0 = start0 + item.range.length
		let iversion = item.data.version
		let meta = item.data

		if meta.version != version
			let start1 = doc.idoc.offsetAtVersion(start0,meta.version)
			let end1 = doc.idoc.offsetAtVersion(end0,meta.version)

			log('syncItem',start0,end0,iversion,start1,end1,version)

			if start0 != start1 or end1 != end0
				console.log 'update position on sync'
				self.dirty = yes

			item.range = {
				offset: start1
				length: end1 - start1
				start: doc.positionAt(start1)
				end: doc.positionAt(end1)
			}

			let text = doc.doc.getText!.slice(start1,end1)

			if text != meta.text
				log 'text content of diagnostic range changed',meta.text,text
				meta.text = text
				item.remove = yes

			item.data.version = version

		return item

	def sync
		let version = doc.idoc.version
		for item in all
			syncItem(item,version)

		if dirty
			send!

		self

	def send
		dirty = no
		all = all.filter do !$1.remove
		if all.length
			console.log 'send diagnostics',all
		doc.program.connection.sendDiagnostics(uri: doc.uri, diagnostics: all)

	def sanc
		send!
	
###
{
	severity: sev
	message: msg.messageText or msg
	range: {start: start, end: end }
}
###