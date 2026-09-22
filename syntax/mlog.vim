" Vim syntax file
" Language: mlog (Mindustry Logic, compiled output of conveycode)

if exists("b:current_syntax")
  finish
endif

syn case match

" Opcodes: only when the first token on the line (optional leading whitespace)
syn match mlogOpcode  "\%(^\s*\)\@<=\<\%(read\|write\|draw\|print\|printchar\|format\|drawflush\|printflush\|getlink\|control\|radar\|sensor\|set\|op\|lookup\|packcolor\|wait\|stop\|end\|jump\|ubind\|ucontrol\|uradar\|ulocate\)\>"

" Comparators used as jump conditions
syn keyword mlogComparator equal notEqual lessThan lessThanEq greaterThan greaterThanEq strictEqual always

" Labels: bare identifier + colon, alone on a line
syn match mlogLabel   "^\s*\zs\w\+:\s*$"

" Booleans
syn keyword mlogBoolean true false

" @constants (matches conv side; hyphens allowed, e.g. @copper, @counter)
syn match mlogConstant "@[[:alnum:]_-]\+"

" Strings (double-quoted only; no comment syntax in mlog)
syn region mlogString  start=+"+ skip=+\\\\\|\\"+ end=+"+

" Numbers
syn match mlogNumber   "\<0[xX][0-9a-fA-F]\+\>"
syn match mlogNumber   "\%(^\|[^[:alnum:]_]\)\@<=[+-]\=\d\+\%(\.\d\+\)\=\%([eE][+-]\=\d\+\)\=\>"

hi def link mlogOpcode     Keyword
hi def link mlogComparator Conditional
hi def link mlogLabel      Label
hi def link mlogBoolean    Boolean
hi def link mlogConstant   Constant
hi def link mlogString     String
hi def link mlogNumber     Number

let b:current_syntax = "mlog"
