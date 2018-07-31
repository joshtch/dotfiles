" Place this in ~/.vim/syntax/text.vim and Vim will pick it up automagically for
" text files. (Must have `syntax on`)
" Vim syntax file
" Language: text
" Creator: Chris Penner
" Last Modified By: Josh Howe
" Latest Revision: 15 Dec 2017
" From https://gist.github.com/ChrisPenner/f81959a62d93e39ce7fd

if exists("b:current_syntax")
  finish
endif

"----------------------------------------------------------------/
" Regex for capitalized words, add your own matches here:
syn match beginSentence "\<[A-Z][a-z]*\('[a-z]\+\)\?\>"
"----------------------------------------------------------------------------/
"  Setup syntax highlighting
"----------------------------------------------------------------------------/
"
let b:current_syntax = "text"

hi def link beginSentence       Todo
" Choose other options to get a different colour:
" Valid options: Comment Constant Function Keyword Operator PreProc Repeat
" Special Statement Type Typedef
