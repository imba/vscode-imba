
export class Program

	def rewriteDefinitions items
		for item in items
			let ifile = js2imba[item.fileName]
			ifile.originalDocumentSpanFor(item) if ifile
		return items