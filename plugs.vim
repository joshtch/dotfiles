" vim:set ft=vim tw=80 sw=4 et fen fdm=marker fmr=\ {{{,\ }}} :

" Download and install vim-plug from git repo {{{
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" If plugins not yet installed, auto-run plugin installation and setup on startup {{{
let s:plugdir = $MYTMP . '/bundle/'
if !isdirectory(s:plugdir)
  augroup InstallVimPlug
      autocmd!
    autocmd VimEnter * PlugInstall | source $MYVIMRC
  augroup END
endif
call plug#begin(s:plugdir)

" }}}
" Conditional Activation helper function for Plug {{{
" See vim-plug wiki for details:
" https://github.com/junegunn/vim-plug/wiki/faq#conditional-activation
function! Cond(cond, ...)
  let opts = get(a:000, 0, {})
  return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

" }}}
" Plug Plugins: {{{
" Appearance: {{{
Plug 'altercation/vim-colors-solarized'
Plug 'vim-airline/vim-airline'
    \| Plug 'vim-airline/vim-airline-themes'

" }}}
" Text Objects: {{{
Plug 'coderifous/textobj-word-column.vim'
Plug 'kana/vim-textobj-user'
    \| Plug 'kana/vim-textobj-line'
    \| Plug 'kana/vim-textobj-entire'
Plug 'michaeljsmith/vim-indent-object'
"Plug 'wellle/targets.vim' " This messes up vim-niceblock

" }}}
" Movement: {{{
Plug 'christoomey/vim-tmux-navigator'
Plug 'unblevable/quick-scope'

" }}}
" IDElike Features: {{{
Plug 'AndrewRadev/splitjoin.vim'
"Plug 'christianrondeau/vim-base64'
Plug '~/vim-base64'
Plug 'jaxbot/browserlink.vim', { 'for' : [ 'htm_', 'html', 'html4', 'htmlm4', 'asciidoc'] }
"Plug 'SirVer/ultisnips'
    "\| Plug 'honza/vim-snippets'
"Plug 'majutsushi/tagbar', { 'for' : [
            "\ 'ant', 'asm', 'asp', 'awk', 'basic', 'beta', 'c',
            "\ 'cpp', 'csharp', 'cobol', 'bat', 'eiffel', 'erlang', 'flex',
            "\ 'fortran', 'html', 'java', 'javascript', 'lisp', 'lua', 'make',
            "\ 'matlab', 'ocaml', 'pascal', 'perl', 'php', 'python', 'rexx',
            "\ 'ruby', 'scheme', 'sh', 'slang', 'sml', 'sql', 'tcl', 'tex', 'vb',
            "\ 'vera', 'verilog', 'vhdl', 'vim', 'yacc' ],
            "\ 'on' : [
            "\ 'TagbarOpen', 'TagbarClose', 'TagbarToggle', 'Tagbar',
            "\ 'TagbarOpenAutoClose', 'TagbarTogglePause', 'TagbarSetFoldlevel',
            "\ 'TagbarShowTag', 'TagbarCurrentTag', 'TagbarGetTypeConfig',
            "\ 'TagbarDebug', 'TagbarDebugEnd' ] }
Plug 'tpope/vim-dispatch', { 'on' : [ 'Make', 'Copen', 'Dispatch', 'FocusDispatch', 'Start' ] }
Plug 'tpope/vim-fugitive'
Plug 'tyru/open-browser.vim', Cond(!has('nvim'), { 'on' : [
            \ '<Plug>(openbrowser-open)', '<Plug>(openbrowser-search)',
            \ '<Plug>(openbrowser-smart-search)' ] } )
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-abolish', { 'on' : [ 'Subvert', 'Abolish', '<Plug>Coerce' ] }
"Plug 'tpope/vim-vinegar', { 'for': 'netrw' }
"Plug 'scrooloose/syntastic'
Plug 'skywind3000/asyncrun.vim'
Plug 'w0rp/ale'
    \| Plug 'dbakker/vim-lint', { 'for' : 'vim' }
"Plug 'Yggdroot/indentLine'
Plug 'zweifisch/pipe2eval'
"Plug 'prettier/vim-prettier', {
            "\ 'do': 'npm install',
            "\ 'for': ['javascript', 'typescript', 'css', 'less', 'scss'] }

" }}}
" Operators: {{{
Plug 'godlygeek/tabular', { 'on': [ 'Tab', 'Tabularize' ] }
Plug 'kana/vim-niceblock', { 'on' : [
            \ '<Plug>(niceblock-I)', '<Plug>(niceblock-A)' ] }
"Plug 'scrooloose/nerdcommenter' , { 'on' : [
            "\   '<Plug>NerdCommenterComment',
            "\   '<Plug>NerdCommenterNested',
            "\   '<Plug>NerdCommenterToggle',
            "\   '<Plug>NerdCommenterMinimal',
            "\   '<Plug>NerdCommenterInvert',
            "\   '<Plug>NerdCommenterSexy',
            "\   '<Plug>NerdCommenterYank',
            "\   '<Plug>NerdCommenterToEol',
            "\   '<Plug>NerdCommenterAppend',
            "\   '<Plug>NerdCommenterInsert',
            "\   '<Plug>NerdCommenterAlignleft',
            "\   '<Plug>NerdCommenterUncomment',
            "\   '<Plug>NerdCommenterAlignboth'
            "\   ]
            "\ }
Plug 'tommcdo/vim-exchange', { 'on': [ '<Plug>(Exchange)',
            \ '<Plug>(ExchangeClear)', '<Plug>(ExchangeLine)' ] }
"Plug 'tpope/vim-capslock', { 'on' : '<Plug>CapsLockToggle' }
Plug 'tpope/vim-surround'
"Plug 'PeterRincker/vim-argumentative'

" }}}
" Syntax Highlighting: {{{
" TODO: Use a Language Server Protocol Client instead of individual plugins?
"   See http://langserver.org
Plug 'sheerun/vim-polyglot'
Plug 'EricGebhart/SAS-Vim', { 'for' : 'sas' }
Plug 'jalvesaq/Nvim-R', { 'for' : 'r' }
Plug 'mrsipan/vim-rst', { 'for' : 'rst' }
Plug 'vim-pandoc/vim-pandoc-syntax', { 'for': 'pandoc' }
Plug 'justinmk/vim-syntax-extra', { 'for': [ 'c', 'yacc', 'lex' ] }
Plug 'vim-scripts/txt.vim'
"Plug 'vimez/vim-tmux', { 'for' : 'conf' }

" }}}
" Language Specific Extras: {{{
Plug 'vim-pandoc/vim-pandoc', { 'for' : [
            \ 'text', 'txt', 'html', 'htm', 'json', 'latex', 'tex', 'ltx',
            \ 'markdown', 'mkd', 'md', 'pandoc', 'pdk', 'pd', 'pdc', 'hs',
            \ 'rst', 'textile' ] }
Plug 'pangloss/vim-javascript', { 'for' : 'javascript' }
Plug 'nelstrom/vim-markdown-folding', { 'for': 'markdown' }
"Plug 'scrooloose/vim-slumlord', { 'for': 'plantuml' }
"Plug 'Rykka/InstantRst', { 'for' : 'rst' }
"Plug 'Rykka/rhythm.css', { 'for' : 'rst' }
Plug 'douglascrockford/jslint', { 'for' : 'js' }
Plug 'dahu/vim-asciidoc', { 'for' : 'asciidoc' }
            \| Plug 'dahu/vimple', { 'for' : 'asciidoc' }
            \| Plug 'dahu/asif', { 'for' : 'asciidoc' }
            \| Plug 'Raimondi/VimRegStyle', { 'for' : 'asciidoc' }
Plug 'jceb/vim-orgmode', { 'for': 'org' }
Plug 'vim-scripts/TeX-PDF', { 'for' : 'tex' }

" }}}
" Vim Functionality Extending: {{{
Plug 'ciaranm/securemodelines'
Plug 'tpope/vim-repeat'
Plug 'merlinrebrovic/focus.vim', { 'on' : '<Plug>FocusModeToggle' }
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-unimpaired'
Plug 'vim-scripts/bufkill.vim', { 'on': [
            \ 'BA', 'BB', 'BD', 'BF', 'BUN', 'BW', 'BUNDO',
            \ '<Plug>BufKillAlt', '<Plug>BufKillBangAlt', '<Plug>BufKillBack',
            \ '<Plug>BufKillBangBack', '<Plug>BufKillForward', '<Plug>BufKillBangForward',
            \ '<Plug>BufKillBun', '<Plug>BufKillBangBun', '<Plug>BufKillBd',
            \ '<Plug>BufKillBangBd', '<Plug>BufKillBw', '<Plug>BufKillBangBw',
            \ '<Plug>BufKillUndo'
            \ ] }
Plug 'ConradIrwin/vim-bracketed-paste', Cond(&term =~? 'xterm.*')
Plug 'tpope/vim-scriptease', { 'on': [
            \   'PP', 'PPmsg', 'Runtime', 'Disarm', 'Scriptnames', 'Verbose',
            \   'Time', 'Breakadd', 'Breakdel', 'Vedit', 'Vsplit', 'Vopen',
            \   'Vread', 'Vvsplit', 'Vtabedit',
            \   '<Plug>ScripteaseFilter', '<Plug>ScripteaseFilter_',
            \   '<Plug>ScripteaseSynnames'
            \  ] }
Plug 'inkarkat/vim-ingo-library'
            \| Plug 'inkarkat/vim-SyntaxRange', { 'on' : [ 'SyntaxIgnore', 'SyntaxInclude' ] }
Plug 'chrisbra/NrrwRgn'
"Plug 'vim-scripts/restore_view.vim'
"Plug 'tpope/vim-sensible'
"Plug 'ntpeters/vim-better-whitespace'
"Plug '~/vim-spacetrails'
"Plug 'vim-scripts/utl.vim'
Plug 'itchyny/calendar.vim', { 'on' : [ 'Calendar', '<Plug>(calendar)' ] }
Plug 'tpope/vim-speeddating', { 'on' : [
            \   '<Plug>SpeedDatingUp', '<Plug>SpeedDatingDown',
            \   '<Plug>SpeedDatingNowUTC', '<Plug>SpeedDatingNowLocal',
            \   'SpeedDatingFormat'
            \  ] }

" }}}
call plug#end()

" }}}
