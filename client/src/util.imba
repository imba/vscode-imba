import { window} from 'vscode'
import np from 'path'

let debugChannel = window.createOutputChannel("Imba Debug")

export def log msg,...rest
	if debugChannel
		debugChannel.appendLine(msg)
		if rest.length
			debugChannel.appendLine(JSON.stringify(rest))
			

export def toPath doc
	let path = np.normalize(doc.fileName or doc.fsPath or doc.uri..fsPath)
	path.split('\\').join('/')