import {Base} from './base'
import {Stream,RemoteStream} from './stream'

export class Util < Base
    @state = 'test'
    @sta

    static def ping
        123

    static def bind
        self

    @stream = RemoteStream.new

    def setup
        self

    def incr
        1