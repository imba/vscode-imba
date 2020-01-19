
# <reference types="/Users/sindre/repos/imba/index"/>

import {Util} from './util'
import './setup'
import './component'

Util.bind()
Util.ping()
HTMLElement
Math.random
let u = Util.new()
u.state = 'test'
u.add(1,2)
u.add(1,22)

tag app-root
    def setup
        self

    def render
        <self title='root'>
            <app-todo title='one' kind=1> "Hello"
            <app-todo titl='two' kind=2> "Hello"
            <app-todo title='three'> "Hello"
            <app-link title='three'> "Hello"
            <app-item title='three'> "Hello"

# let ext = Extern.new
# ext.hello()