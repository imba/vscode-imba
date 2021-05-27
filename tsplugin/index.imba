const compilerOptions = {
	checkJs: true # only check the imba js?!
}
import * as util from './util'

import Compiler from './compiler'
import Service from './service'
import ImbaScript from './script'
import Patcher from './patches'

def patch ts
	ts.Extension.Imba = '.tsimba'
	# Intercept messages coming from vscode and messages
	# being sent back to vscode
	# util.extend(ts.server.Session.prototype,patches.Session)
	# util.extend(ts.server.ScriptInfo.prototype,patches.ScriptInfo)
	# util.extend(ts.server.TextStorage.prototype,patches.TextStorage)
	# util.extend(ts.server.ScriptVersionCache.prototype,patches.ScriptVersionCache)
	# util.extend(ts.server.ProjectService.prototype,patches.ProjectService)
	# util.extend(ts.sys,patches.System)
	# util.extend(ts,patches.TS)
	
	Patcher(ts)

	# let subs = patches.subclasses(ts)
	# global.subs = subs
	# 
	# for own k,v of subs
	# 	ts[k] = v
	# 
	Object.defineProperty(ts.server.ScriptInfo.prototype,Symbol.for('#imba'),{
		get: do
			return null unless util.isImba(this.path)
			unless this.##imba
				this.##imba = new ImbaScript(this)
				this.##imba.setup!
			return this.##imba
	})

	Object.defineProperty(ts.server.ScriptInfo.prototype,'im',{get: do this.#imba})
	
def init modules = {}
	let ts = global.ts = global.TS = modules.typescript
	
	if ts.#patched =? yes
		patch(ts)

	return ts.ils = global.ils ||= new Service

module.exports = init