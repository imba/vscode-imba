'use strict';

Object.defineProperty(exports, '__esModule', { value: true });

var vscode = require('vscode');
var vscodeLanguageclient = require('vscode-languageclient');

function iter$(a){ return a ? (a.toIterable ? a.toIterable() : a) : []; }var path = require('path');

// TODO(scanf): handle workspace folder and multiple client connections

class ClientAdapter {
	
	
	uriToEditor(uri,version){
		
		for (let i = 0, items = iter$(vscode.window.visibleTextEditors), len = items.length; i < len; i++) {
			let editor = items[i];
			
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
	
	
	var semanticTypes = {
		accessor: vscode.window.createTextEditorDecorationType({
			light: {color: '#509DB5'},
			dark: {
				color: '#92b4d6',
				border: '2px #384450 dashed',
				borderWidth: '0px 0px 1px 0px',
				borderSpacing: '2px'
			},
			borderRadius: '2px',
			rangeBehavior: 1
		}),
		imported: vscode.window.createTextEditorDecorationType({
			light: {color: '#509DB5'},
			dark: {
				color: '#82c1f9',
				border: '2px #384450 dashed',
				borderWidth: '0px 0px 1px 0px'
			},
			borderRadius: '2px',
			rangeBehavior: 1
		})
	};
	
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
		
		client.onNotification('entities',function({uri: uri,version: version,markers: markers}) {
			
			
			let editor = adapter.uriToEditor(uri,version);
			console.log('received entities',uri,version,markers,editor);
			
			if (!(editor)) { return }			
			var decorations = {};
			
			for (let i = 0, items = iter$(markers), len = items.length; i < len; i++) {
				let mark = items[i];
				
				let [name,kind,loc,length,start,end] = mark;
				let group = (decorations[kind] || (decorations[kind] = []));
				group.push({range: {start: start,end: end}});
			}			
			console.log('decorations',decorations);
			for (let i = 0, keys = Object.keys(decorations), l = keys.length, name, items, type; i < l; i++){
				name = keys[i];items = decorations[name];
				if (type = semanticTypes[name]) {
					
					editor.setDecorations(type,items);
				}			}			return;
			
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
//# sourceMappingURL=data:application/json;charset=utf-8;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiaW5kZXguanMiLCJzb3VyY2VzIjpbInNyYy9pbmRleC5pbWJhIl0sInNvdXJjZXNDb250ZW50IjpbInZhciBwYXRoID0gcmVxdWlyZSAncGF0aCdcblxuaW1wb3J0IHt3aW5kb3csIGxhbmd1YWdlcywgSW5kZW50QWN0aW9uLCB3b3Jrc3BhY2UsU25pcHBldFN0cmluZyxQb3NpdGlvbn0gZnJvbSAndnNjb2RlJ1xuaW1wb3J0IHtMYW5ndWFnZUNsaWVudCwgVHJhbnNwb3J0S2luZCwgUmV2ZWFsT3V0cHV0Q2hhbm5lbE9ufSBmcm9tICd2c2NvZGUtbGFuZ3VhZ2VjbGllbnQnXG5cbiMgVE9ETyhzY2FuZik6IGhhbmRsZSB3b3Jrc3BhY2UgZm9sZGVyIGFuZCBtdWx0aXBsZSBjbGllbnQgY29ubmVjdGlvbnNcblxuY2xhc3MgQ2xpZW50QWRhcHRlclxuXHRcblx0ZGVmIHVyaVRvRWRpdG9yIHVyaSwgdmVyc2lvblxuXHRcdGZvciBlZGl0b3IgaW4gd2luZG93LnZpc2libGVUZXh0RWRpdG9yc1xuXHRcdFx0bGV0IGRvYyA9IGVkaXRvci5kb2N1bWVudFxuXHRcdFx0aWYgZG9jICYmIHVyaSA9PT0gZG9jLnVyaS50b1N0cmluZygpXG5cdFx0XHRcdGlmIHZlcnNpb24gYW5kIGRvYy52ZXJzaW9uICE9IHZlcnNpb25cblx0XHRcdFx0XHRjb250aW51ZVxuXHRcdFx0XHRyZXR1cm4gZWRpdG9yXG5cdFx0cmV0dXJuIG51bGxcblxudmFyIGFkYXB0ZXIgPSBDbGllbnRBZGFwdGVyLm5ld1xuXG5leHBvcnQgZGVmIGFjdGl2YXRlIGNvbnRleHRcblx0dmFyIHNlcnZlck1vZHVsZSA9IGNvbnRleHQuYXNBYnNvbHV0ZVBhdGgocGF0aC5qb2luKCdzZXJ2ZXInLCAnaW5kZXguanMnKSlcblx0dmFyIGRlYnVnT3B0aW9ucyA9IHsgZXhlY0FyZ3Y6IFsnLS1ub2xhenknLCAnLS1pbnNwZWN0PTYwMDUnXSB9XG5cdFxuXHRjb25zb2xlLmxvZyBzZXJ2ZXJNb2R1bGUsIGRlYnVnT3B0aW9ucyAjICwgZGVidWdTZXJ2ZXJNb2R1bGVcblx0XG5cdHZhciBzZXJ2ZXJPcHRpb25zID0ge1xuXHRcdHJ1bjoge21vZHVsZTogc2VydmVyTW9kdWxlLCB0cmFuc3BvcnQ6IFRyYW5zcG9ydEtpbmQuaXBjLCBvcHRpb25zOiBkZWJ1Z09wdGlvbnMgfVxuXHRcdGRlYnVnOiB7bW9kdWxlOiBzZXJ2ZXJNb2R1bGUsIHRyYW5zcG9ydDogVHJhbnNwb3J0S2luZC5pcGMsIG9wdGlvbnM6IGRlYnVnT3B0aW9ucyB9XG5cdH1cblx0XG5cdHZhciBjbGllbnRPcHRpb25zID0ge1xuXHRcdGRvY3VtZW50U2VsZWN0b3I6IFt7c2NoZW1lOiAnZmlsZScsIGxhbmd1YWdlOiAnaW1iYSd9XVxuXHRcdHN5bmNocm9uaXplOiB7IGNvbmZpZ3VyYXRpb25TZWN0aW9uOiBbJ2ltYmEnXSB9XG5cdFx0cmV2ZWFsT3V0cHV0Q2hhbm5lbE9uOiBSZXZlYWxPdXRwdXRDaGFubmVsT24uSW5mb1xuXHRcdGluaXRpYWxpemF0aW9uT3B0aW9uczoge1xuXHRcdFx0c29tZXRoaW5nOiAxXG5cdFx0XHRvdGhlcjogMTAwXG5cdFx0fVxuXHR9XG5cdFxuXHR2YXIgY2xpZW50ID0gTGFuZ3VhZ2VDbGllbnQubmV3KCdpbWJhJywgJ0ltYmEgTGFuZ3VhZ2UgU2VydmVyJywgc2VydmVyT3B0aW9ucywgY2xpZW50T3B0aW9ucylcblx0dmFyIGRpc3Bvc2FibGUgPSBjbGllbnQuc3RhcnQoKVxuXHRcblx0XG5cdHZhciBzZW1hbnRpY1R5cGVzID1cblx0XHRhY2Nlc3Nvcjogd2luZG93LmNyZWF0ZVRleHRFZGl0b3JEZWNvcmF0aW9uVHlwZSh7XG5cdFx0XHRsaWdodDoge2NvbG9yOiAnIzUwOURCNSd9XG5cdFx0XHRkYXJrOiB7XG5cdFx0XHRcdGNvbG9yOiAnIzkyYjRkNicsXG5cdFx0XHRcdGJvcmRlcjogJzJweCAjMzg0NDUwIGRhc2hlZCcsXG5cdFx0XHRcdGJvcmRlcldpZHRoOiAnMHB4IDBweCAxcHggMHB4J1xuXHRcdFx0XHRib3JkZXJTcGFjaW5nOiAnMnB4J1xuXHRcdFx0fVxuXHRcdFx0Ym9yZGVyUmFkaXVzOiAnMnB4J1xuXHRcdFx0cmFuZ2VCZWhhdmlvcjogMVxuXHRcdH0pXG5cdFx0aW1wb3J0ZWQ6IHdpbmRvdy5jcmVhdGVUZXh0RWRpdG9yRGVjb3JhdGlvblR5cGUoe1xuXHRcdFx0bGlnaHQ6IHtjb2xvcjogJyM1MDlEQjUnfVxuXHRcdFx0ZGFyazoge1xuXHRcdFx0XHRjb2xvcjogJyM4MmMxZjknLFxuXHRcdFx0XHRib3JkZXI6ICcycHggIzM4NDQ1MCBkYXNoZWQnLFxuXHRcdFx0XHRib3JkZXJXaWR0aDogJzBweCAwcHggMXB4IDBweCdcblx0XHRcdH1cblx0XHRcdGJvcmRlclJhZGl1czogJzJweCdcblx0XHRcdHJhbmdlQmVoYXZpb3I6IDFcblx0XHR9KVxuXG5cdGNvbnRleHQuc3Vic2NyaXB0aW9ucy5wdXNoKGRpc3Bvc2FibGUpXG5cblx0XG5cdGNsaWVudC5vblJlYWR5KCkudGhlbiBkb1xuXG5cdFx0d29ya3NwYWNlLm9uRGlkUmVuYW1lRmlsZXMgZG8gfGV2fFxuXHRcdFx0Y29uc29sZS5sb2cgJ3dvcmtzcGFjZSBvbkRpZFJlbmFtZUZpbGVzJyxldlxuXHRcdFx0Y2xpZW50LnNlbmROb3RpZmljYXRpb24oJ29uRGlkUmVuYW1lRmlsZXMnLGV2KVxuXHRcdFx0XG5cdFx0Y2xpZW50Lm9uTm90aWZpY2F0aW9uKCdjbG9zZUFuZ2xlQnJhY2tldCcpIGRvIHxwYXJhbXN8XG5cdFx0XHRsZXQgZWRpdG9yID0gd2luZG93LmFjdGl2ZVRleHRFZGl0b3Jcblx0XHRcdGNvbnNvbGUubG9nICdlZGl0ISEhJyxlZGl0b3IscGFyYW1zXG5cdFx0XHR0cnlcblx0XHRcdFx0ZmFsc2UgJiYgZWRpdG9yLmVkaXQgZG8gfGVkaXRzfFxuXHRcdFx0XHRcdGxldCBwb3MgPSBQb3NpdGlvbi5uZXcocGFyYW1zLnBvc2l0aW9uLmxpbmUscGFyYW1zLnBvc2l0aW9uLmNoYXJhY3Rlcilcblx0XHRcdFx0XHRjb25zb2xlLmxvZyAnZWRpdEJ1aWxkZXInLGVkaXRzLHBvc1xuXHRcdFx0XHRcdGVkaXRzLmluc2VydChwb3MsJz4nKVxuXHRcdFx0XHRsZXQgc3RyID0gU25pcHBldFN0cmluZy5uZXcoJyQwPicpXG5cdFx0XHRcdGVkaXRvci5pbnNlcnRTbmlwcGV0KHN0cixudWxsLHt1bmRvU3RvcEJlZm9yZTogZmFsc2UsdW5kb1N0b3BBZnRlcjogdHJ1ZX0pXG5cdFx0XHRjYXRjaCBlXG5cdFx0XHRcdGNvbnNvbGUubG9nIFwiZXJyb3JcIixlXG5cblx0XHRjbGllbnQub25Ob3RpZmljYXRpb24oJ2VudGl0aWVzJykgZG8gfHt1cmksdmVyc2lvbixtYXJrZXJzfXxcblxuXHRcdFx0bGV0IGVkaXRvciA9IGFkYXB0ZXIudXJpVG9FZGl0b3IodXJpLHZlcnNpb24pXG5cdFx0XHRjb25zb2xlLmxvZyAncmVjZWl2ZWQgZW50aXRpZXMnLHVyaSx2ZXJzaW9uLG1hcmtlcnMsZWRpdG9yXG5cdFx0XHRcblx0XHRcdHJldHVybiB1bmxlc3MgZWRpdG9yXG5cdFx0XHRcblx0XHRcdHZhciBkZWNvcmF0aW9ucyA9IHt9XG5cdFx0XHRcblx0XHRcdGZvciBtYXJrIGluIG1hcmtlcnNcblx0XHRcdFx0bGV0IFtuYW1lLGtpbmQsbG9jLGxlbmd0aCxzdGFydCxlbmRdID0gbWFya1x0XHRcdFx0XG5cdFx0XHRcdGxldCByYW5nZSA9IHtzdGFydDogc3RhcnQsIGVuZDogZW5kfVxuXHRcdFx0XHRsZXQgZ3JvdXAgPSAoZGVjb3JhdGlvbnNba2luZF0gfHw9IFtdKVxuXHRcdFx0XHRncm91cC5wdXNoKHJhbmdlOiB7c3RhcnQ6IHN0YXJ0LCBlbmQ6IGVuZH0pXG5cblx0XHRcdGNvbnNvbGUubG9nICdkZWNvcmF0aW9ucycsZGVjb3JhdGlvbnNcblx0XHRcdGZvciBvd24gbmFtZSxpdGVtcyBvZiBkZWNvcmF0aW9uc1xuXHRcdFx0XHRpZiBsZXQgdHlwZSA9IHNlbWFudGljVHlwZXNbbmFtZV1cblx0XHRcdFx0XHRlZGl0b3Iuc2V0RGVjb3JhdGlvbnModHlwZSwgaXRlbXMpXG5cdFx0XHRyZXR1cm5cblx0XHRcdFxuXHRcblx0XHRsYW5ndWFnZXMucmVnaXN0ZXJDb21wbGV0aW9uSXRlbVByb3ZpZGVyKCdpbWJhJywge1xuXHRcdFx0ZGVmIHByb3ZpZGVDb21wbGV0aW9uSXRlbXMgZG9jdW1lbnQsIHBvc2l0aW9uLCB0b2tlblxuXHRcdFx0XHRjb25zb2xlLmxvZygncHJvdmlkZUNvbXBsZXRpb25JdGVtcycsdG9rZW4pXG5cdFx0XHRcdGxldCBlZGl0b3IgPSB3aW5kb3cuYWN0aXZlVGV4dEVkaXRvclxuXHRcdFx0XHRyZXR1cm5cblx0XHRcdFx0IyByZXR1cm4ge2l0ZW1zOiBbXX1cblx0XHRcdFx0IyByZXR1cm4gbmV3IEhvdmVyKCdJIGFtIGEgaG92ZXIhJylcblx0XHR9KVxuXHRcblx0IyBzZXQgbGFuZ3VhZ2UgY29uZmlndXJhdGlvblxuXHRsYW5ndWFnZXMuc2V0TGFuZ3VhZ2VDb25maWd1cmF0aW9uKCdpbWJhJyx7XG5cdFx0d29yZFBhdHRlcm46IC8oLT9cXGQqXFwuXFxkXFx3Kil8KFteXFxgXFx+XFwhXFxAXFwjJVxcXlxcJlxcKlxcKFxcKVxcPVxcJFxcLVxcK1xcW1xce1xcXVxcfVxcXFxcXHxcXDtcXDpcXCdcXFwiXFwsXFwuXFw8XFw+XFwvXFw/XFxzXSspL2csXG5cdFx0b25FbnRlclJ1bGVzOiBbe1xuXHRcdFx0YmVmb3JlVGV4dDogL15cXHMqKD86ZXhwb3J0IGRlZnxkZWZ8KGV4cG9ydCAoZGVmYXVsdCApPyk/KHN0YXRpYyApPyhkZWZ8Z2V0fHNldCl8KGV4cG9ydCAoZGVmYXVsdCApPyk/KGNsYXNzfHRhZyl8Zm9yfGlmfGVsaWZ8ZWxzZXx3aGlsZXx0cnl8d2l0aHxmaW5hbGx5fGV4Y2VwdHxhc3luYykuKj8kLyxcblx0XHRcdGFjdGlvbjogeyBpbmRlbnRBY3Rpb246IEluZGVudEFjdGlvbi5JbmRlbnQgfVxuXHRcdH0se1xuXHRcdFx0YmVmb3JlVGV4dDogL1xccyooPzpkbylcXHMqKFxcfC4qXFx8XFxzKik/JC8sXG5cdFx0XHRhY3Rpb246IHsgaW5kZW50QWN0aW9uOiBJbmRlbnRBY3Rpb24uSW5kZW50IH1cblx0XHR9XVxuXHR9KSJdLCJuYW1lcyI6WyJ3aW5kb3ciLCJUcmFuc3BvcnRLaW5kIiwiUmV2ZWFsT3V0cHV0Q2hhbm5lbE9uIiwiTGFuZ3VhZ2VDbGllbnQiLCJ3b3Jrc3BhY2UiLCJQb3NpdGlvbiIsIlNuaXBwZXRTdHJpbmciLCJsYW5ndWFnZXMiLCJJbmRlbnRBY3Rpb24iXSwibWFwcGluZ3MiOiI7Ozs7Ozs7NkVBQUksSUFBSSxHQUFXLFFBQUEsTUFBTSxDQUFBOzs7O0FBT3pCLE1BQU0sYUFBYTs7O0NBRWQsV0FBVyxDQUFDLEdBQUcsQ0FBRSxPQUFPLENBQUE7O0VBQzNCLDhCQUFjQSxhQUFNLENBQUMsa0JBQWtCLHFDQUFBO09BQW5DLE1BQU07O09BQ0wsR0FBRyxHQUFHLE1BQU0sQ0FBQyxRQUFRO0dBQ3pCLElBQUcsR0FBRyxJQUFJLEdBQUcsS0FBSyxHQUFHLENBQUMsR0FBRyxDQUFDLFFBQVEsRUFBRSxFQUFBOztJQUNuQyxJQUFHLE9BQU8sSUFBSyxHQUFHLENBQUMsT0FBTyxJQUFJLE9BQU8sRUFBQTs7O1NBRXJDLE9BQU8sTUFBTTtTQUNmLE9BQU8sSUFBSTtFQUFBO0FBQUE7SUFFVCxPQUFPLEdBQWlCLElBQWQsYUFBYSxFQUFJOztBQUV4QixTQUFJLFFBQVEsQ0FBQyxPQUFPLENBQUE7O0tBQ3RCLFlBQVksR0FBRyxPQUFPLENBQUMsY0FBYyxDQUFDLElBQUksQ0FBQyxJQUFJLENBQUMsUUFBUSxDQUFFLFVBQVUsQ0FBQyxDQUFDO0tBQ3RFLFlBQVksR0FBRyxDQUFFLFFBQVEsR0FBRyxVQUFVLENBQUUsZ0JBQWdCLENBQUEsQ0FBRzs7Q0FFL0QsT0FBTyxDQUFDLEdBQUcsQ0FBQyxZQUFZLENBQUUsWUFBWTs7S0FFbEMsYUFBYSxHQUFHO0VBQ25CLEdBQUcsRUFBRSxDQUFDLE1BQU0sRUFBRSxZQUFZLENBQUUsU0FBUyxFQUFFQyxrQ0FBYSxDQUFDLEdBQUcsQ0FBRSxPQUFP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
