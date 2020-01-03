import LanguageClient, TransportKind, RevealOutputChannelOn from 'vscode-languageclient'
import window from 'vscode'

import ClientAdapter from './ClientAdapter'

class WorkspaceHandler
    
    def initialize workspace
        @sortedWorkspaceFolders = []
        @workspace = workspace
        @clients = new Map() 
        @defaultClient = undefined
        @adapter = ClientAdapter.new			

        @workspace.onDidChangeWorkspaceFolders do
            @sortedWorkspaceFolders = []

    def activate t, s
        @outputChannel = t
        @serverModule = s
    
    def purgeClient event
        for folder in event:removed
            let client = @clients.get(folder:uri.toString())
            if client
                @clients.delete(folder:uri.toString())
                client.stop()

    def clients
        @clients
    
    def stopAllClients
        let p = []
        if defaultClient
            p.push(defaultClient.stop())
        for client in @clients.values()
            p.push(client.stop())

    def sortedWorkspaceFolders
        if @sortedWorkspaceFolders:length == 0
            return [] if not workspace:workspaceFolders
            @sortedWorkspaceFolders = workspace.workspaceFolders.map do |folder|
                let res = folder:uri.toString()
                if res.charAt(res:length - 1) !== '/'
                    res = res + '/'
                return res
            @sortedWorkspaceFolders = @sortedWorkspaceFolders.sort do |lhs, rhs|
                lhs:length - rhs:length
        @sortedWorkspaceFolders

    def getOuterMostWorkspaceFolder folder
        let sorted = self.sortedWorkspaceFolders()
        for element of sorted
            let uri = folder:uri.toString()
            if uri.charAt(uri:length - 1) != '/'
                uri = uri + '/'
            if uri.startsWith(element)
                return @workspace.getWorkspaceFolder(Uri.parse(element))
        return folder

    def didOpenTextDocument doc
        # We are only interested in Imba sources, everything else should be ignored
        return if doc:languageId != 'imba' # or document:uri:scheme != 'file'

        let uri = doc:uri
        if !defaultClient
            let debugOptions = { execArgv: ['--nolazy', '--inspect=6005'] }
            var serverOptions = {
                run: {module: serverModule, transport: TransportKind:ipc, options: debugOptions }
                debug: {module: serverModule, transport: TransportKind:ipc, options: debugOptions }
            }
            var clientOptions = {
                documentSelector: [{scheme: 'file', language: 'imba'}]
                synchronize: { configurationSection: ['imba'] }
                revealOutputChannelOn: RevealOutputChannelOn.Info,
                outputChannel: @outputChannel,
                diagnosticCollectionName: 'imba-language-server',
                initializationOptions: {
                    something: 1
                    other: 100
                }
            }
            defaultClient = LanguageClient.new('imba', 'Imba Language Server', serverOptions, clientOptions)
            defaultClient.start()
            self.configure(defaultClient)
            return

        let folder = @workspace.getWorkspaceFolder(uri)
        return if not folder
        
        folder = self.getOuterMostWorkspaceFolder()

        if clients.has(folder:uri.toString())
            let uniquePort = 6005 + clients:size
            let debugOptions = { execArgv: ['--nolazy', "--inspect={uniquePort}"] }
            var serverOptions = {
                run: {module: serverModule, transport: TransportKind:ipc, options: debugOptions }
                debug: {module: serverModule, transport: TransportKind:ipc, options: debugOptions }
            }
            var clientOptions = {
                documentSelector: [{scheme: 'file', language: 'imba', pattern: "{folder.uri.fsPath}/**/*"}]
                # synchronize: { configurationSection: ['imba'] }
                revealOutputChannelOn: RevealOutputChannelOn.Info,
                outputChannel: @outputChannel,
                diagnosticCollectionName: 'imba-language-server',
                initializationOptions: {
                    something: 1
                    other: 100
                }
            }
            let client = LanguageClient.new('imba', 'Imba Language Server', serverOptions, clientOptions)
            client.start()
            clients.set(folder:uri.toString(), client)
            self.configure(defaultClient)
            return
    
    def configure client        	
        var type = window.createTextEditorDecorationType({
            light: {color: '#509DB5'},
            dark: {color: '#dbdcb2'},
            rangeBehavior: 1
        })
        client.onReady.then do
            client.onNotification('entities') do |uri,version,markers|
                let editor = @adapter.uriToEditor(uri,version)
                
                return unless editor

                var styles = {
                    RootScope: ["#d6bdce","#509DB5"]
                    "import": ['#91b7ea','#91b7ea']
                }

                var decorations = for marker in markers
                    let color = styles[marker:type] or styles[marker:scope]
                    
                    {
                        range: marker:range
                        hoverMessage: "variable {marker:name}"
                        renderOptions: color ? {dark: {color: color[0]}, light: {color: color[1]}, rangeBehavior: 1} : null
                    }
                
                editor.setDecorations(type, decorations)        
