" bundles.vim
set nocompatible
filetype off

" NeoBundle:
if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim/
    if !filereadable(expand('~/.vim/bundle/neobundle.vim/doc/neobundle.txt'))
        !mkdir -p ~/.vim/bundle/neobundle.vim &&
                \ git clone 'https://github.com/Shougo/neobundle.vim.git'
                \ ~/.vim/bundle/neobundle.vim
    endif
endif
call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'

" Appearance:
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'bling/vim-airline'
NeoBundle 'vim-airline/vim-airline-themes'

" Text Objects:
NeoBundle 'coderifous/textobj-word-column.vim'
NeoBundle 'kana/vim-textobj-line', {
            \ 'depends' : 'kana/vim-textobj-user'
            \ }
NeoBundle 'kana/vim-textobj-entire', {
            \ 'depends' : 'kana/vim-textobj-user'
            \ }
NeoBundle 'michaeljsmith/vim-indent-object'
"NeoBundle 'wellle/targets.vim'

" Movement:
NeoBundle 'christoomey/vim-tmux-navigator'
NeoBundleLazy 'matchit.zip', { 'autoload' : { 'mappings' : [ '%', 'g%', '[%', ']%', 'a%' ] }}
NeoBundleLazy 'unblevable/quick-scope'

" IDElike Features:
NeoBundleLazy 'Shougo/unite.vim', {
            \ 'depends' : 'Shougo/vimproc',
            \ 'autoload' : { 'commands' : 'Unite' }
            \ }
"NeoBundle 'SirVer/ultisnips'
"NeoBundleLazy 'honza/vim-snippets', { 'depends' : 'SirVer/ultisnips' }
NeoBundleLazy 'majutsushi/tagbar', { 'autoload': {
            \ 'filetypes' :  [ 'ant', 'asm', 'asp', 'awk', 'basic', 'beta', 'c',
            \ 'cpp', 'csharp', 'cobol', 'bat', 'eiffel', 'erlang', 'flex',
            \ 'fortran', 'html', 'java', 'javascript', 'lisp', 'lua', 'make',
            \ 'matlab', 'ocaml', 'pascal', 'perl', 'php', 'python', 'rexx',
            \ 'ruby', 'scheme', 'sh', 'slang', 'sml', 'sql', 'tcl', 'tex', 'vb',
            \ 'vera', 'verilog', 'vhdl', 'vim', 'yacc' ] }}
NeoBundleLazy 'tpope/vim-dispatch', { 'autoload' : {
            \ 'commands' : [
            \   'Make', 'Make!', 'Copen', 'Copen!', 'Dispatch', 'Dispatch!',
            \   'FocusDispatch', 'FocusDispatch!', 'Start', 'Start!'
            \   ]
            \ }}
NeoBundle 'tpope/vim-fugitive'
NeoBundleLazy 'tyru/open-browser.vim', { 'autoload': {
            \ 'mappings' : [
            \  '<Plug>(openbrowser-open)',
            \  '<Plug>(openbrowser-search)',
            \  '<Plug>(openbrowser-smart-search)'
            \  ],
            \ 'commands' : 'OpenBrowserSmartSearch' }}
NeoBundle 'mhinz/vim-signify'
NeoBundleLazy 'tpope/vim-vinegar', { 'autoload': { 'filetypes' : 'netrw' }}
NeoBundle 'tsukkee/unite-tag', { 'depends' : 'Shougo/unite.vim' }
NeoBundle 'Shougo/neomru.vim', { 'depends' : 'Shougo/unite.vim' }
NeoBundle 'scrooloose/syntastic'
NeoBundleLazy 'zweifisch/pipe2eval'

" Operators:
NeoBundleLazy 'godlygeek/tabular', { 'autoload': { 'commands' : 'Tabularize' }}
"NeoBundleLazy 'kana/vim-niceblock', { 'autoload': { 'mappings' : [ '<Plug>(niceblock-I)', '<Plug>(niceblock-A)' ] }}
NeoBundleLazy 'scrooloose/nerdcommenter' , { 'autoload' : {
            \ 'mappings' : [
            \   '<Plug>NERDCommenterComment',
            \   '<Plug>NERDCommenterNested',
            \   '<Plug>NERDCommenterToggle',
            \   '<Plug>NERDCommenterMinimal',
            \   '<Plug>NERDCommenterInvert',
            \   '<Plug>NERDCommenterSexy',
            \   '<Plug>NERDCommenterYank',
            \   '<Plug>NERDCommenterToEOL',
            \   '<Plug>NERDCommenterAppend',
            \   '<Plug>NERDCommenterInsert',
            \   '<Plug>NERDCommenterAlignLeft',
            \   '<Plug>NERDCommenterUncomment',
            \   '<Plug>NERDCommenterAlignBoth'
            \   ]
            \ }}
NeoBundleLazy 'tommcdo/vim-exchange', { 'autoload': {
            \ 'mappings' : [
            \   '<Plug>(Exchange)', '<Plug>(ExchangeClear)', '<Plug>(ExchangeLine)'
            \  ]
            \ }}
NeoBundleLazy 'tpope/vim-capslock', { 'autoload' : {
            \ 'mappings' : [ '<C-g>u' ]}}
NeoBundleLazy 'tpope/vim-surround', { 'autoload' : {
            \ 'mappings' : [
            \  '<Plug>Dsurround',
            \  '<Plug>Csurround',
            \  '<Plug>Ysurround',
            \  '<Plug>YSurround',
            \  '<Plug>Yssurround',
            \  '<Plug>YSsurround',
            \  '<Plug>YSsurround',
            \  '<Plug>VSurround',
            \  '<Plug>VgSurround',
            \  '<Plug>Isurround',
            \  '<Plug>ISurround',
            \  ]
            \ }}

" Language Specific Syntax Handling:
NeoBundle 'dogrover/vim-pentadactyl'
NeoBundleLazy 'vim-scripts/TeX-PDF', { 'autoload' : { 'filetypes' : 'tex' }}
NeoBundleLazy 'dbakker/vim-lint', {
            \ 'autoload' : { 'filetypes' : 'vim' },
            \ 'depends' : 'scrooloose/syntastic'
            \ }
NeoBundleLazy 'vimez/vim-tmux', { 'autoload': { 'filetypes' : 'conf' }}
NeoBundle     'vim-pandoc/vim-pandoc'
NeoBundleLazy 'vim-pandoc/vim-pandoc-syntax', { 'autoload': { 'filetypes' : 'pandoc' }}
NeoBundleLazy 'nelstrom/vim-markdown-folding', { 'autoload': { 'filetypes' : 'markdown' }}

" Vim Functionality Extending:
NeoBundle 'Shougo/vimproc', {
            \ 'build' : {
            \       'windows' : 'make -f make_mingw32.mak',
            \       'cygwin'  : 'make -f make_cygwin.mak',
            \       'mac'     : 'make -f make_mac.mak',
            \       'unix'    : 'make -f make_unix.mak'
            \      }
            \ }
NeoBundleLazy 'ciaranm/securemodelines'
NeoBundle 'tpope/vim-repeat'
NeoBundleLazy 'merlinrebrovic/focus.vim', { 'autoload' : { 'mappings' : '<Plug>FocusModeToggle' }}
NeoBundle 'dockyard/vim-easydir'
NeoBundle 'tpope/vim-rsi'
NeoBundle 'tpope/vim-unimpaired'
NeoBundleLazy 'vim-scripts/bufkill.vim', { 'autoload': {
            \ 'commands' : [ 'BD', 'BUN', 'BW', 'BB', 'BF' ] }}
NeoBundle 'ConradIrwin/vim-bracketed-paste', {
            \ 'terminal' : 1, 'disabled' : (&term !~? "xterm.*") }
NeoBundle 'ardagnir/vimbed'
NeoBundleLazy 'tpope/vim-scriptease', { 'autoload': {
            \ 'commands' : [
            \   'PP', 'PPmsg', 'Runtime', 'Disarm', 'Scriptnames', 'Verbose',
            \   'Time', 'Breakadd', 'Breakdel', 'Vedit', 'Vsplit', 'Vopen',
            \   'Vread', 'Vvsplit', 'Vtabedit'
            \  ],
            \ 'mappings' : [
            \   '<Plug>ScripteaseFilter', '<Plug>ScripteaseFilter_',
            \   '<Plug>ScripteaseSynnames'
            \  ]
            \ }}

call neobundle#end()
filetype plugin indent on
NeoBundleCheck
