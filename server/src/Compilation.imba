# yes
import * as ts from 'typescript'
import {Diagnostic} from './Diagnostics'
import {Position,Range} from 'imba/program'
const imbac = require 'imba/compiler'
const imba1c = require '../imba1.compiler.js'

export default class Compilation
	
	constructor f
		file = f
		doc = f.idoc
		done = no
		
		# i2o - input (frozen/old doc) to output conversion
		# d2o - live doc to frozen output
		# d2i - live doc to frozen input
		# o2d - frozen output to live doc

		iversion = doc.version
		ibody = doc.content
		ioptions = {
			target: 'tsc'
			platform: 'tsc'
			imbaPath: null
			silent: yes
			sourcemap: 'hidden'
			filename: file.fileName
			sourcePath: file.fileName
		}
		
	def o2iRange start, end, fuzzy = yes
		# the whole body of the file
		if start == 0 and end == obody.length
			return doc.rangeAt(0,ibody.length)
		
		for [ts0,ts1,imba0,imba1] in locs.spans
				if start == ts0 and end == ts1
					return doc.rangeAt(imba0,imba1)
		
		if fuzzy
			let i0 = o2i(start)
			let i1 = o2i(end)
			return doc.rangeAt(i0,i1)
		return null
		
	def o2dRange start, end, fuzzy = yes
		let range = o2iRange(start,end,fuzzy)
		return doc.rangeAt(i2d(range[0]),i2d(range[1]))
		
	def o2i o
		if o.start != undefined
			let start = Number(o.start)
			let end = start + Number(o.length)
			return o2iRange(start,end,yes)
		let val = null

		let spans = locs.spans.filter do(pair)
			o >= pair[0] and pair[1] >= o

		if let span = spans[0]
			let into = (o - span[0]) / (span[1] - span[0])
			let offset = Math.floor(into * (span[3] - span[2]))
			# console.log 'found originalLocFor',jsloc,spans
			if span[0] == o
				val = span[2]
			elif span[1] == o
				val = span[3]
			else
				val = span[2] + offset

		return  val
		
	def d2i d
		doc.historicalOffset(d,iversion)
		
	def i2d i
		if i and typeof i[0] == 'number'
			return doc.rangeAt(i2d(i[0]),i2d(i[1]))
		doc.offsetAtVersion(i,iversion)
		
	def d2o d
		i2o(d2i(d))
		
	def o2d o
		i2d(o2i(o))
		
	def i2o i
		let spans = locs.spans.filter do(pair)
			i >= pair[2] and pair[3] >= i

		if let span = spans[0]
			let into = (i - span[2]) / (span[3] - span[2])
			let offset = Math.floor(into * (span[1] - span[0]))
			# console.log 'found generatedLocFor',loc,spans
			if i == span[2]
				return span[0]
			elif i == span[3]
				return span[1]
			else
				return span[0] + offset

		return null
		
	get diagnostics
		#diagnostics ||= result.diagnostics.map do(item)
			new Diagnostic(item,self)
		
	def compile
		return self if result

		try
			done = yes
			let compiler = file.isLegacy ? imba1c : imbac
			let res = file.util.time(&,"{file.fileName} compiled in") do
				compiler.compile(ibody,ioptions)
			# console.log 'compiled!',res
			obody = res.js.replace(/\$CARET\$/g,'valueOf')
			self.result = res
			self.locs = res.locs
			
			let errors = res.errors or []
			
			if errors.length
				yes
			else
				self.js = ts.ScriptSnapshot.fromString(obody)
				self.js.iversion = iversion
				self.js.#compilation = self
			return self
		catch e
			yes