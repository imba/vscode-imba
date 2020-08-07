import {Stream} from "./stream"

export class Base

	state = 'paused'
	stream = Stream.new
	
	static def ping
		123

export class Hello