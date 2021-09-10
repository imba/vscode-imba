# Changelog

## 3.0.7
* Added completions for css transitions & easing
* Fixed style modifier completions
* Added setting for toggling shorthand style properties in completions
* Fixed highlighting comments at the end of selectors

## 3.0.6
* Fixed issues with auto-import completions
* Improved css completions and hover information

## 3.0.5
* Make completions work with latest vscode (1.59.0)
* Make auto-imports work with latest TypeScript nightlies

## 3.0.4

* Change icon for tag completions
* Automatic typings and intellisense for class/tag augmentations
* Improved completions and hover-info for event modifiers
* Fixed formatting of completion documentation
* Only complete auto-imports with enter (or tab - if enabled)
* Fixed highlighting for commented line inside tag literal

## 3.0.3

* Made completions less trigger-happy. Completions are now only committed with special characters after typing at least one character to filter the list. Fixes (#92)
* Fixed auto-completion of css properties in selector (#93)
* Don't show errors from imba compiler until document is saved
* Show event-icon for tag event completions
* Show warning whenever an auto-import is triggered (#94)

## 3.0.2

* Fixed autocompletions for imported identifiers
* Improved auto-import behaviour
* Various minor fixes

## 3.0.1

* Added css property completions for transform aliases (x,y,z,scale-x,scale-y,skew-x,skew-y)
* Improved css background value completions
* Improved css justify/align value completions
* Fixed completions for methods/properties starting with two or more underscores
* Hide global tags from `global.` completions
* Add completion for `new` keyword
* Disable space (` `) as a completion trigger
* Filter global completions based on first character
* Updated to imba@2.0.0-alpha.141
* Fixed block comment highlighting for imba1 files
* Fixed continue/break highlighting

## 3.0.0

The tooling has been re-implemented as a typescript server plugin, which makes it a lot more powerful.

* Much better type inference and completions
* Completions for event-handlers and event-modifiers
* Completions for type annotations (ie `let item\RequestOptions`)
* Highlight unnused variables and imports
* Import imba files from js & ts with full IDE support
* Renaming & refactoring across imba/js/ts files

## 2.5.3
* Improved markdown highlighting in ImbaDark
* Added highlighting for markdown imba codeblocks

## 2.5.2
* Upgraded to imba 2 alpha 114
* Fixed languageserver crash

## 2.5.1
* Upgraded to imba 2 alpha 113
* Fixed several highlighting bugs
* Add css style block folding commands (shift+alt+m to toggle)

## 2.5.0
* Upgraded to imba 2 alpha 100
    (make sure to also update your project to alpha 100)

## 2.4.9
* Upgraded to imba 2 alpha 97

## 2.4.8
* Upgraded to imba 2 alpha 92
* Improve completions for border-* properties
* Improve completions for transition
* Show hover info for style properties
* Show hover info for box-shadows++


## 2.4.7
* Add completions for font-size
* Add completions for font-family
* Add completions for box-shadow

## 2.4.6
* Upgraded to imba 2 alpha 91
* Add completions for border-radius
* Add completions and hover info for colors
* Add completions and hover info for easings

## 2.4.5
* Upgraded to imba 2 alpha 80
* Showing tag definitions in outline
* Showing elements in outline
* Allow configuring types via imbaconfig.json

## 2.4.4
* Upgraded to imba 2 alpha 78

## 2.4.3
* Upgraded to imba 2 alpha 77
* Darkened background colors in ImbaDark theme

## 2.4.2
* Fixed issues with multiline string highlighting
* Upgraded to imba 2 alpha 76

## 2.4.0
* Improved support for imba1 files

## 2.3.0

* Using official semantic tokens api from vscode
* Moved to new imba parser for completions & semantic tokens
* Improved handling of diagnostics
* Disabled completions for path, auto-import and more (will return in next version)

## 2.1.1

* Add basic highlighting support for new style syntax

## 1.5.2

* Highlight CSS blocks in comments.
* Fix crash in empty Imba file.
* Highlight `const` keyword.
* Upgrade to Imba 1.5.2

## 0.5.1
* Make symbols/outline view work correctly
* Upgrade to Imba 1.4.4

## 0.5.0
* Make variable highlighting work with latest vscode
* Upgrade to Imba 1.4.3

## 0.3.0
* Upgrade to Imba 1.3.1

## 0.2.0
* Add symbol indexing

## 0.1.0
* Initial release