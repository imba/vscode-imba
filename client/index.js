'use strict';

Object.defineProperty(exports, '__esModule', { value: true });

var vscode = require('vscode');
var vscodeLanguageclient = require('vscode-languageclient');

function iter$(a){ return a ? (a.toIterable ? a.toIterable() : a) : []; }var path = require('path');

// TODO(scanf): handle workspace folder and multiple client connections

class ClientAdapter {
	
	
	uriToEditor(uri,version){
		
		for (let i = 0, items = iter$(vscode.window.visibleTextEditors), len = items.length, editor; i < len; i++) {
			editor = items[i];
			
			let doc = editor.document;
			if (doc && uri === doc.uri.toString()) {
				
				if (version && doc.version != version) {
					
					continue;
				}				return editor;
			}		}		return null;
	}
}
var adapter = new ClientAdapter();

function activate(context){
	
	var serverModule = context.asAbsolutePath(path.join('server','index.js'));
	var debugOptions = {execArgv: ['--nolazy','--inspect=6005']};
	
	console.log(serverModule,debugOptions);// , debugServerModule
	
	var serverOptions = {
		run: {module: serverModule,transport: vscodeLanguageclient.TransportKind.ipc,options: debugOptions},
		debug: {module: serverModule,transport: vscodeLanguageclient.TransportKind.ipc,options: debugOptions}
	};
	
	var clientOptions = {
		documentSelector: [{scheme: 'file',language: 'imba'}],
		synchronize: {configurationSection: ['imba']},
		revealOutputChannelOn: vscodeLanguageclient.RevealOutputChannelOn.Info,
		initializationOptions: {
			something: 1,
			other: 100
		}
	};
	
	var client = new vscodeLanguageclient.LanguageClient('imba','Imba Language Server',serverOptions,clientOptions);
	var disposable = client.start();
	
	var type = vscode.window.createTextEditorDecorationType({
		light: {color: '#509DB5'},
		dark: {color: '#dbdcb2'},
		rangeBehavior: 1
	});
	
	context.subscriptions.push(disposable);
	
	
	client.onReady().then(function() {
		
		
		vscode.workspace.onDidRenameFiles(function(ev) {
			
			console.log('workspace onDidRenameFiles',ev);
			return client.sendNotification('onDidRenameFiles',ev);
			
		});
		client.onNotification('closeAngleBracket',function(params) {
			
			let editor = vscode.window.activeTextEditor;
			console.log('edit!!!',editor,params);
			try {
				
				false && editor.edit(function(edits) {
					
					let pos = new vscode.Position(params.position.line,params.position.character);
					console.log('editBuilder',edits,pos);
					return edits.insert(pos,'>');
				});
				let str = new vscode.SnippetString('$0>');
				return editor.insertSnippet(str,null,{undoStopBefore: false,undoStopAfter: true});
			} catch (e) {
				
				return console.log("error",e);
			}		});
		
		client.onNotification('entities',function(uri,version,markers) {
			
			let editor = adapter.uriToEditor(uri,version);
			
			if (!(editor)) { return }			
			var styles = {
				RootScope: ["#d6bdce","#509DB5"],
				"import": ['#91b7ea','#91b7ea']
			};
			
			let res = [];
			for (let i = 0, items = iter$(markers), len = items.length, marker; i < len; i++) {
				marker = items[i];
				
				let color = styles[marker.type] || styles[marker.scope];
				
				res.push({
					range: marker.range,
					hoverMessage: ("variable " + (marker.name)),
					renderOptions: color ? {dark: {color: color[0]},light: {color: color[1]},rangeBehavior: 1} : null
				});
			}			var decorations = res;
			
			return editor.setDecorations(type,decorations);
		});
		
		return vscode.languages.registerCompletionItemProvider('imba',{
			provideCompletionItems(document,position,token){
				
				console.log('provideCompletionItems',token);
				let editor = vscode.window.activeTextEditor;
				return;
				// return {items: []}
				// return new Hover('I am a hover!')
			}
		});
	});
	
	// set language configuration
	return vscode.languages.setLanguageConfiguration('imba',{
		wordPattern: /(-?\d*\.\d\w*)|([^\`\~\!\@\#%\^\&\*\(\)\=\$\-\+\[\{\]\}\\\|\;\:\'\"\,\.\<\>\/\?\s]+)/g,
		onEnterRules: [{
			beforeText: /^\s*(?:export def|def|(export (default )?)?(static )?(def|get|set)|(export (default )?)?(class|tag)|for|if|elif|else|while|try|with|finally|except|async).*?$/,
			action: {indentAction: vscode.IndentAction.Indent}
		},{
			beforeText: /\s*(?:do)\s*(\|.*\|\s*)?$/,
			action: {indentAction: vscode.IndentAction.Indent}
		}]
	});
}

exports.activate = activate;
//# sourceMappingURL=data:application/json;charset=utf-8;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiaW5kZXguanMiLCJzb3VyY2VzIjpbInNyYy9pbmRleC5pbWJhIl0sInNvdXJjZXNDb250ZW50IjpbInZhciBwYXRoID0gcmVxdWlyZSAncGF0aCdcblxuaW1wb3J0IHt3aW5kb3csIGxhbmd1YWdlcywgSW5kZW50QWN0aW9uLCB3b3Jrc3BhY2UsU25pcHBldFN0cmluZyxQb3NpdGlvbn0gZnJvbSAndnNjb2RlJ1xuaW1wb3J0IHtMYW5ndWFnZUNsaWVudCwgVHJhbnNwb3J0S2luZCwgUmV2ZWFsT3V0cHV0Q2hhbm5lbE9ufSBmcm9tICd2c2NvZGUtbGFuZ3VhZ2VjbGllbnQnXG5cbiMgVE9ETyhzY2FuZik6IGhhbmRsZSB3b3Jrc3BhY2UgZm9sZGVyIGFuZCBtdWx0aXBsZSBjbGllbnQgY29ubmVjdGlvbnNcblxuY2xhc3MgQ2xpZW50QWRhcHRlclxuXHRcblx0ZGVmIHVyaVRvRWRpdG9yIHVyaSwgdmVyc2lvblxuXHRcdGZvciBlZGl0b3IgaW4gd2luZG93LnZpc2libGVUZXh0RWRpdG9yc1xuXHRcdFx0bGV0IGRvYyA9IGVkaXRvci5kb2N1bWVudFxuXHRcdFx0aWYgZG9jICYmIHVyaSA9PT0gZG9jLnVyaS50b1N0cmluZygpXG5cdFx0XHRcdGlmIHZlcnNpb24gYW5kIGRvYy52ZXJzaW9uICE9IHZlcnNpb25cblx0XHRcdFx0XHRjb250aW51ZVxuXHRcdFx0XHRyZXR1cm4gZWRpdG9yXG5cdFx0cmV0dXJuIG51bGxcblxudmFyIGFkYXB0ZXIgPSBDbGllbnRBZGFwdGVyLm5ld1xuXG5leHBvcnQgZGVmIGFjdGl2YXRlIGNvbnRleHRcblx0dmFyIHNlcnZlck1vZHVsZSA9IGNvbnRleHQuYXNBYnNvbHV0ZVBhdGgocGF0aC5qb2luKCdzZXJ2ZXInLCAnaW5kZXguanMnKSlcblx0dmFyIGRlYnVnT3B0aW9ucyA9IHsgZXhlY0FyZ3Y6IFsnLS1ub2xhenknLCAnLS1pbnNwZWN0PTYwMDUnXSB9XG5cdFxuXHRjb25zb2xlLmxvZyBzZXJ2ZXJNb2R1bGUsIGRlYnVnT3B0aW9ucyAjICwgZGVidWdTZXJ2ZXJNb2R1bGVcblx0XG5cdHZhciBzZXJ2ZXJPcHRpb25zID0ge1xuXHRcdHJ1bjoge21vZHVsZTogc2VydmVyTW9kdWxlLCB0cmFuc3BvcnQ6IFRyYW5zcG9ydEtpbmQuaXBjLCBvcHRpb25zOiBkZWJ1Z09wdGlvbnMgfVxuXHRcdGRlYnVnOiB7bW9kdWxlOiBzZXJ2ZXJNb2R1bGUsIHRyYW5zcG9ydDogVHJhbnNwb3J0S2luZC5pcGMsIG9wdGlvbnM6IGRlYnVnT3B0aW9ucyB9XG5cdH1cblx0XG5cdHZhciBjbGllbnRPcHRpb25zID0ge1xuXHRcdGRvY3VtZW50U2VsZWN0b3I6IFt7c2NoZW1lOiAnZmlsZScsIGxhbmd1YWdlOiAnaW1iYSd9XVxuXHRcdHN5bmNocm9uaXplOiB7IGNvbmZpZ3VyYXRpb25TZWN0aW9uOiBbJ2ltYmEnXSB9XG5cdFx0cmV2ZWFsT3V0cHV0Q2hhbm5lbE9uOiBSZXZlYWxPdXRwdXRDaGFubmVsT24uSW5mb1xuXHRcdGluaXRpYWxpemF0aW9uT3B0aW9uczoge1xuXHRcdFx0c29tZXRoaW5nOiAxXG5cdFx0XHRvdGhlcjogMTAwXG5cdFx0fVxuXHR9XG5cdFxuXHR2YXIgY2xpZW50ID0gTGFuZ3VhZ2VDbGllbnQubmV3KCdpbWJhJywgJ0ltYmEgTGFuZ3VhZ2UgU2VydmVyJywgc2VydmVyT3B0aW9ucywgY2xpZW50T3B0aW9ucylcblx0dmFyIGRpc3Bvc2FibGUgPSBjbGllbnQuc3RhcnQoKVxuXHRcblx0dmFyIHR5cGUgPSB3aW5kb3cuY3JlYXRlVGV4dEVkaXRvckRlY29yYXRpb25UeXBlKHtcblx0XHRsaWdodDoge2NvbG9yOiAnIzUwOURCNSd9LFxuXHRcdGRhcms6IHtjb2xvcjogJyNkYmRjYjInfSxcblx0XHRyYW5nZUJlaGF2aW9yOiAxXG5cdH0pXG5cblx0Y29udGV4dC5zdWJzY3JpcHRpb25zLnB1c2goZGlzcG9zYWJsZSlcblxuXHRcblx0Y2xpZW50Lm9uUmVhZHkoKS50aGVuIGRvXG5cblx0XHR3b3Jrc3BhY2Uub25EaWRSZW5hbWVGaWxlcyBkbyB8ZXZ8XG5cdFx0XHRjb25zb2xlLmxvZyAnd29ya3NwYWNlIG9uRGlkUmVuYW1lRmlsZXMnLGV2XG5cdFx0XHRjbGllbnQuc2VuZE5vdGlmaWNhdGlvbignb25EaWRSZW5hbWVGaWxlcycsZXYpXG5cdFx0XHRcblx0XHRjbGllbnQub25Ob3RpZmljYXRpb24oJ2Nsb3NlQW5nbGVCcmFja2V0JykgZG8gfHBhcmFtc3xcblx0XHRcdGxldCBlZGl0b3IgPSB3aW5kb3cuYWN0aXZlVGV4dEVkaXRvclxuXHRcdFx0Y29uc29sZS5sb2cgJ2VkaXQhISEnLGVkaXRvcixwYXJhbXNcblx0XHRcdHRyeVxuXHRcdFx0XHRmYWxzZSAmJiBlZGl0b3IuZWRpdCBkbyB8ZWRpdHN8XG5cdFx0XHRcdFx0bGV0IHBvcyA9IFBvc2l0aW9uLm5ldyhwYXJhbXMucG9zaXRpb24ubGluZSxwYXJhbXMucG9zaXRpb24uY2hhcmFjdGVyKVxuXHRcdFx0XHRcdGNvbnNvbGUubG9nICdlZGl0QnVpbGRlcicsZWRpdHMscG9zXG5cdFx0XHRcdFx0ZWRpdHMuaW5zZXJ0KHBvcywnPicpXG5cdFx0XHRcdGxldCBzdHIgPSBTbmlwcGV0U3RyaW5nLm5ldygnJDA+Jylcblx0XHRcdFx0ZWRpdG9yLmluc2VydFNuaXBwZXQoc3RyLG51bGwse3VuZG9TdG9wQmVmb3JlOiBmYWxzZSx1bmRvU3RvcEFmdGVyOiB0cnVlfSlcblx0XHRcdGNhdGNoIGVcblx0XHRcdFx0Y29uc29sZS5sb2cgXCJlcnJvclwiLGVcblxuXHRcdGNsaWVudC5vbk5vdGlmaWNhdGlvbignZW50aXRpZXMnKSBkbyB8dXJpLHZlcnNpb24sbWFya2Vyc3xcblx0XHRcdGxldCBlZGl0b3IgPSBhZGFwdGVyLnVyaVRvRWRpdG9yKHVyaSx2ZXJzaW9uKVxuXHRcdFx0XG5cdFx0XHRyZXR1cm4gdW5sZXNzIGVkaXRvclxuXG5cdFx0XHR2YXIgc3R5bGVzID0ge1xuXHRcdFx0XHRSb290U2NvcGU6IFtcIiNkNmJkY2VcIixcIiM1MDlEQjVcIl1cblx0XHRcdFx0XCJpbXBvcnRcIjogWycjOTFiN2VhJywnIzkxYjdlYSddXG5cdFx0XHR9XG5cblx0XHRcdHZhciBkZWNvcmF0aW9ucyA9IGZvciBtYXJrZXIgaW4gbWFya2Vyc1xuXHRcdFx0XHRsZXQgY29sb3IgPSBzdHlsZXNbbWFya2VyLnR5cGVdIG9yIHN0eWxlc1ttYXJrZXIuc2NvcGVdXG5cdFx0XHRcdFxuXHRcdFx0XHR7XG5cdFx0XHRcdFx0cmFuZ2U6IG1hcmtlci5yYW5nZVxuXHRcdFx0XHRcdGhvdmVyTWVzc2FnZTogXCJ2YXJpYWJsZSB7bWFya2VyLm5hbWV9XCJcblx0XHRcdFx0XHRyZW5kZXJPcHRpb25zOiBjb2xvciA/IHtkYXJrOiB7Y29sb3I6IGNvbG9yWzBdfSwgbGlnaHQ6IHtjb2xvcjogY29sb3JbMV19LCByYW5nZUJlaGF2aW9yOiAxfSA6IG51bGxcblx0XHRcdFx0fVxuXHRcdFx0XG5cdFx0XHRlZGl0b3Iuc2V0RGVjb3JhdGlvbnModHlwZSwgZGVjb3JhdGlvbnMpXG5cdFxuXHRcdGxhbmd1YWdlcy5yZWdpc3RlckNvbXBsZXRpb25JdGVtUHJvdmlkZXIoJ2ltYmEnLCB7XG5cdFx0XHRkZWYgcHJvdmlkZUNvbXBsZXRpb25JdGVtcyBkb2N1bWVudCwgcG9zaXRpb24sIHRva2VuXG5cdFx0XHRcdGNvbnNvbGUubG9nKCdwcm92aWRlQ29tcGxldGlvbkl0ZW1zJyx0b2tlbilcblx0XHRcdFx0bGV0IGVkaXRvciA9IHdpbmRvdy5hY3RpdmVUZXh0RWRpdG9yXG5cdFx0XHRcdHJldHVyblxuXHRcdFx0XHQjIHJldHVybiB7aXRlbXM6IFtdfVxuXHRcdFx0XHQjIHJldHVybiBuZXcgSG92ZXIoJ0kgYW0gYSBob3ZlciEnKVxuXHRcdH0pXG5cdFxuXHQjIHNldCBsYW5ndWFnZSBjb25maWd1cmF0aW9uXG5cdGxhbmd1YWdlcy5zZXRMYW5ndWFnZUNvbmZpZ3VyYXRpb24oJ2ltYmEnLHtcblx0XHR3b3JkUGF0dGVybjogLygtP1xcZCpcXC5cXGRcXHcqKXwoW15cXGBcXH5cXCFcXEBcXCMlXFxeXFwmXFwqXFwoXFwpXFw9XFwkXFwtXFwrXFxbXFx7XFxdXFx9XFxcXFxcfFxcO1xcOlxcJ1xcXCJcXCxcXC5cXDxcXD5cXC9cXD9cXHNdKykvZyxcblx0XHRvbkVudGVyUnVsZXM6IFt7XG5cdFx0XHRiZWZvcmVUZXh0OiAvXlxccyooPzpleHBvcnQgZGVmfGRlZnwoZXhwb3J0IChkZWZhdWx0ICk/KT8oc3RhdGljICk/KGRlZnxnZXR8c2V0KXwoZXhwb3J0IChkZWZhdWx0ICk/KT8oY2xhc3N8dGFnKXxmb3J8aWZ8ZWxpZnxlbHNlfHdoaWxlfHRyeXx3aXRofGZpbmFsbHl8ZXhjZXB0fGFzeW5jKS4qPyQvLFxuXHRcdFx0YWN0aW9uOiB7IGluZGVudEFjdGlvbjogSW5kZW50QWN0aW9uLkluZGVudCB9XG5cdFx0fSx7XG5cdFx0XHRiZWZvcmVUZXh0OiAvXFxzKig/OmRvKVxccyooXFx8LipcXHxcXHMqKT8kLyxcblx0XHRcdGFjdGlvbjogeyBpbmRlbnRBY3Rpb246IEluZGVudEFjdGlvbi5JbmRlbnQgfVxuXHRcdH1dXG5cdH0pIl0sIm5hbWVzIjpbIndpbmRvdyIsIlRyYW5zcG9ydEtpbmQiLCJSZXZlYWxPdXRwdXRDaGFubmVsT24iLCJMYW5ndWFnZUNsaWVudCIsIndvcmtzcGFjZSIsIlBvc2l0aW9uIiwiU25pcHBldFN0cmluZyIsImxhbmd1YWdlcyIsIkluZGVudEFjdGlvbiJdLCJtYXBwaW5ncyI6Ijs7Ozs7Ozt5RUFBSSxJQUFBLElBQUksR0FBVyxRQUFBLE1BQU0sQ0FBQTs7OztBQU96QixNQUFNLGFBQWE7OztDQUVkLFdBQVcsQ0FBQyxHQUFHLENBQUUsT0FBTyxDQUFBOztFQUMzQiw4QkFBY0EsYUFBTSxDQUFDLGtCQUFrQiw2Q0FBQTs7O0dBQ2xDLElBQUEsR0FBRyxHQUFHLE1BQU0sQ0FBQyxRQUFRO0dBQ3pCLElBQUcsR0FBRyxJQUFJLEdBQUcsS0FBSyxHQUFHLENBQUMsR0FBRyxDQUFDLFFBQVEsRUFBRSxFQUFBOztJQUNuQyxJQUFHLE9BQU8sSUFBSyxHQUFHLENB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
