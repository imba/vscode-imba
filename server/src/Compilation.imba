# yes
import * as ts from 'typescript'

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
		
	def o2i offset
		offset
		
	def d2i d
		doc.historicalOffset(d,iversion)
		
	def d2o d
		i2o(d2i(d))
		
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
		
	def compile
		return self if result

		try
			let compiler = file.isLegacy ? imba1c : imbac
			let res = file.util.time(&,"{file.fileName} compiled in") do
				compiler.compile(ibody,ioptions)
			console.log 'compiled!',res
			obody = res.js.replace(/\$CARET\$/g,'valueOf')
			self.result = res
			self.locs = res.locs
			self.js = ts.ScriptSnapshot.fromString(obody)
			self.js.iversion = iversion
			return self
		catch e
			yes