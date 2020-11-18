import {Stream} from "./stream"

export class Base

	state = 'paused'
	stream = new Stream
	
	static def ping
		123

export class Hello