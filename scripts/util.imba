import fs from 'fs'

export class Dts
	name
	stack = []
	out = ''
	pre = ''
	
	def w ln
		out += pre + ln + '\n'
	
	def ind wrap,cb
		push(wrap)
		cb()
		pop!

	def push wrap
		w(wrap + ' {') if wrap
		pre += '\t'
	
	def pop wrap
		pre = pre.slice(0,-1)
		w('}\n')
		
	def save
		yes
		
	def toString
		out