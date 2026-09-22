" Vim syntax file
" Language: mlog (Mindustry Logic, compiled output of conveycode)

if exists("b:current_syntax")
  finish
endif

syn case match

" Comparators used as jump conditions
syn keyword mlogComparator equal notEqual lessThan lessThanEq greaterThan greaterThanEq strictEqual always

" Booleans
syn keyword mlogBoolean true false

" Generic identifiers (variable/register names); the more specific rules
" below (assignment target, label, opcode) are defined after this one so
" they win where they overlap
syn match mlogIdentifier "\h[[:alnum:]_-]*"

" @constants (matches conv side; hyphens allowed, e.g. @copper, @counter)
syn match mlogBuiltin "@[[:alnum:]_-]\+"

" Strings (double-quoted only; no comment syntax in mlog)
syn region mlogString  start=+"+ skip=+\\\\\|\\"+ end=+"+

" Numbers
syn match mlogNumber   "\<0[xX][0-9a-fA-F]\+\>"
syn match mlogNumber   "\%(^\|[^[:alnum:]_]\)\@<=[+-]\=\d\+\%(\.\d\+\)\=\%([eE][+-]\=\d\+\)\=\>"

" `set <target> <value>`: highlight the assignment target distinctly from a
" plain identifier reference. The value keeps the generic identifier color
" (or its own literal color, if it's a number/string/boolean/@constant).
syn match mlogAssignTarget "\%(^\s*set\s\+\)\@<=\h[[:alnum:]_-]*"

" Labels: bare identifier + colon, alone on a line
syn match mlogLabel   "^\s*\zs\w\+:\s*$"

" Opcodes: only when the first token on the line (optional leading whitespace)
syn match mlogOpcode  "\%(^\s*\)\@<=\<\%(read\|write\|draw\|print\|printchar\|format\|drawflush\|printflush\|getlink\|control\|radar\|sensor\|set\|op\|lookup\|packcolor\|wait\|stop\|end\|jump\|ubind\|ucontrol\|uradar\|ulocate\)\>"

hi def link mlogComparator    Conditional
hi def link mlogBoolean       Boolean
hi def link mlogIdentifier    Variable
hi def link mlogBuiltin       Builtin
hi def link mlogString        String
hi def link mlogNumber        Number
hi def link mlogAssignTarget  Identifier
hi def link mlogLabel         Label
hi def link mlogOpcode        Keyword

let b:current_syntax = "mlog"
