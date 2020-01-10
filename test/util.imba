import {Base} from './base'
import {Stream} from './stream'

export class Util < Base
    static def ping
        123

    static def bind
        self

    @stream = Stream.new

    def setup
        self

    def incr
        1