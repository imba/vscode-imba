export class ClientAdapter
	
	def uriToEditor uri, version
		for editor in window:visibleTextEditors
			let doc = editor:document
			if doc && uri === doc:uri.toString
				if version and doc:version != version
					continue
				return editor
		return null