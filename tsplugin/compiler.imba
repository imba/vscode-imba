import * as util from './util'

import {Position,Range} from '../document'
const imbac = require 'imba/compiler'

const ImbaOptions = {
	target: 'tsc'
	platform: 'tsc'
	imbaPath: null
	silent: yes
	sourcemap: 'hidden'
}

export class Compilation
	
	constructor script, src, content
		script = script
		fileName = src
		body = content
		done = no
		o2iCache = {}
		
		# i2o - input (frozen/old doc) to output conversion
		# d2o - live doc to frozen output
		# d2i - live doc to frozen input
		# o2d - frozen output to live doc
		
		options = {...ImbaOptions, fileName: src, sourcePath: src}
		
	def o2iRange start, end, fuzzy = yes
		# the whole body of the file
		if start == 0 and end == js.length
			return [0,body.length]
			# return doc.rangeAt(0,ibody.length)
		
		for [ts0,ts1,imba0,imba1] in locs.spans
			if start == ts0 and end == ts1
				return [imba0,imba1]
				# return doc.rangeAt(imba0,imba1)
	
		if fuzzy
			let i0 = o2i(start)
			let i1 = o2i(end)
			return [i0,i1]
			# return doc.rangeAt(i0,i1)
		return []
		
	def o2dRange start, end, fuzzy = yes
		let range = o2iRange(start,end,fuzzy)
		return i2d(range)
		
	def o2i o, opts = yes
		if o.start != undefined
			let start = Number(o.start)
			let end = start + Number(o.length)
			return o2iRange(start,end,opts)
			
		if o2iCache[o] != null
			return o2iCache[o]

		let val = null
		
		for [ts0,ts1,imba0,imba1] in locs.spans
			if o == ts0
				break val = imba0
			elif o == ts1
				break val = imba1
		
		if val !== null
			return o2iCache[o] = val

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
		input.cache.rewindOffset(d,input.version)
		
	def i2d i
		return null if i == null
		if i and typeof i[0] == 'number'
			return [i2d(i[0]),i2d(i[1])]

		input.cache.forwardOffset(i,input.version)

		
	def d2o d
		i2o(d2i(d))
		
	def o2d o, fuzzy = yes
		i2d(o2i(o,fuzzy))
		
	def i2o i
		return null if i == null
		
		let matches = []
		let bestMatch = null
		
		for [ts0,ts1,imba0,imba1],idx in locs.spans
			if i == imba0
				return ts0
			if i == imba1
				return ts1
			if imba1 > i > imba0
				let tsl = ts1 - ts0
				let isl = imba1 - imba0
				let o = i - imba0
				
				if isl == tsl
					matches.push([ts0 + o,tsl])
				
		if matches.length
			return matches[0][0]

		return null
		
	get diagnostics
		return [] unless result..diagnostics

		#diagnostics ||= result.diagnostics.map do(item)
			new Diagnostic(item,self)
	
	def compileAsync
		#compiling ||= new Promise do(resolve)
			ioptions.sourceId = "aa"
			let res
			let t = Date.now!
			if file.isLegacy
				res = await workers.compile_imba1(ibody,ioptions)
			else
				res = await workers.compile_imba(ibody,ioptions)
				
			self.result = res
			console.log()
			console.log 'compiled async ',file.relName,Date.now! - t
			resolve(self)

	set result res
		#result = res
		done = yes
		if res.js
			self.js = res.js.replace(/\$CARET\$/g,'valueOf')
			self.locs = res.locs
		
		let errors = res.errors or []
		yes
	
	get result
		#result
		
	def compile
		return self if done

		try
			done = yes
			self.result = imbac.compile(body,options)
			#compiling = Promise.resolve(self)
		catch e
			console.log 'compiler crashed',file.relName
			self.result = {diagnostics: []}
			yes
		return self


export default new class Compiler
	
	cache = {}
	
	def lookup src, body
		if cache[body]
			return cache[body]

	def compile script, body
		(new Compilation(script,script.fileName,body)).compile!
	
	def readFile src, body
		if cache[body]
			return cache[body].js
		
		let doc = cache[body] = new Compilation(null,src,body)
		doc.compile!
		util.log('readFile')

		return doc.js or "\n"
		
		# let opts = {...ImbaOptions, fileName: src, sourcePath: src}
		# let res = imbac.compile(body,opts)
		# cache[body] = res
		# util.log("compiled {src}")
		# return res.js