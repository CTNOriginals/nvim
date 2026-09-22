" Vim syntax file
" Language: conveycode (.conv)

if exists("b:current_syntax")
  finish
endif

syn case match

" Keywords
syn keyword conveycodeKeyword     var func
syn keyword conveycodeConditional if else
syn keyword conveycodeStatement   return
syn keyword conveycodeBoolean     true false
syn keyword conveycodeNull        null

" Comments
syn match   conveycodeComment     "\/\/.*$" contains=@Spell

" Strings (three quote styles, backslash escapes)
syn match   conveycodeEscape      display contained "\\."
syn region  conveycodeString      start=+"+  skip=+\\\\\|\\"+ end=+"+  contains=conveycodeEscape,@Spell
syn region  conveycodeString      start=+'+  skip=+\\\\\|\\'+ end=+'+  contains=conveycodeEscape,@Spell
syn region  conveycodeString      start=+`+  skip=+\\\\\|\\`+ end=+`+  contains=conveycodeEscape,@Spell

" Numbers: hex, then signed int/float with optional exponent
syn match   conveycodeNumber      "\<0[xX][0-9a-fA-F]\+\>"
syn match   conveycodeNumber      "\%(^\|[^[:alnum:]_]\)\@<=[+-]\=\d\+\%(\.\d\+\)\=\%([eE][+-]\=\d\+\)\=\>"

" $command, @constant, #link prefixes
syn match   conveycodeCommand     "\$\w\+"
syn match   conveycodeConstant    "@[[:alnum:]_-]\+"
syn match   conveycodeLink        "#\w\+"

" Function name in `func name(` and in call position `name(`
syn match   conveycodeFunction    "\h\w*\ze\s*("

" Operators (1-3 char combos from +-*/%=><!&|)
syn match   conveycodeOperator    "[+\-*/%=><!&|]\{1,3}"

hi def link conveycodeKeyword     Keyword
hi def link conveycodeConditional Conditional
hi def link conveycodeStatement   Statement
hi def link conveycodeBoolean     Boolean
hi def link conveycodeNull        Constant
hi def link conveycodeComment     Comment
hi def link conveycodeString      String
hi def link conveycodeEscape      Special
hi def link conveycodeNumber      Number
hi def link conveycodeCommand     Function
hi def link conveycodeConstant    Constant
hi def link conveycodeLink        Identifier
hi def link conveycodeFunction    Function
hi def link conveycodeOperator    Operator

let b:current_syntax = "conveycode"
