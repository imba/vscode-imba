# Visual Studio Code Language Support for Imba

Imba is programming language for building amazing full-stack webapps. You can
use it on the server and client.  To learn more about Imba visit [https://imba.io](https://imba.io)

This extension provides you with

- Contextual Syntax highlighting, discover errors easier.
- A Scrimba theme that a good default look if you want.
- Better autocompletion, it even works for CSS blocks.

# Usage with legacy (imba 1) files

To make the extension play nice with legacy code you can add project-specific vscode settings in *project*/.vscode/settings.json and add:
```json
{
    "files.associations": {
        "*.imba": "imba1"
    }
}
```