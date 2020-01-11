import {Util} from './util'
import './setup'
import './component'
import {Extern} from './extern'
Util.bind()
Util.ping()
HTMLElement
Math.random
# Util.ping(123)
# Util.pong()
let u = Util.new
u.state = 'test'
u.sta
tag app-root
    def setup
        self

    def render
        <self title='root'>
            <app-todo title='one' kind=1> "Hello"
            <app-todo titles='two' kind=2> "Hello"
            <app-todo title='three'> "Hello"

# let ext = Extern.new
# ext.hello()