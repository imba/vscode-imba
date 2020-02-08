import {Base} from './base'
import {Stream,RemoteStream} from './stream'

export class Util < Base
	@state = 'test'
	@sta
	@plugin
	# @type {string[]} - List of all the items
	
	@items
	
	static def ping
		123

	static def bind
		self

	@stream = RemoteStream.new

	def setup
		@
		self

	def incr
		2

	###*
	@param {number} b - The last number you ant here
	###
	def add a,b
		return a + b