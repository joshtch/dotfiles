" bundles.vim
set nocompatible
filetype off " required!

" Autoinstall NeoBundle:
if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim/
    if !filereadable(expand('~/.vim/bundle/neobundle.vim/doc/neobundle.txt'))
        !mkdir -p ~/.vim/bundle/neobundle.vim &&
                \ git clone 'https://github.com/Shougo/neobundle.vim.git'
                \ ~/.vim/bundle/neobundle.vim
    endif
endif
call neobundle#rc(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'

" Appearance:
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'bling/vim-airline'

" Text Objects:
NeoBundle 'coderifous/textobj-word-column.vim'
NeoBundle 'kana/vim-textobj-line', {
            \ 'depends' : 'kana/vim-textobj-user'
            \ }
NeoBundle 'kana/vim-textobj-entire', {
            \ 'depends' : 'kana/vim-textobj-user'
            \ }
NeoBundle 'michaeljsmith/vim-indent-object'
NeoBundle 'wellle/targets.vim'

" Movement:
NeoBundle 'christoomey/vim-tmux-navigator'

" IDElike Features:
NeoBundleLazy 'Shougo/unite.vim', {
            \ 'depends' : 'Shougo/vimproc',
            \ 'autoload' : { 'commands' : 'Unite' }
            \ }
NeoBundleLazy 'majutsushi/tagbar', {
            \ 'filetypes' :  [ 'ant', 'asm', 'asp', 'awk', 'basic', 'beta', 'c',
            \ 'cpp', 'csharp', 'cobol', 'bat', 'eiffel', 'erlang', 'flex',
            \ 'fortran', 'html', 'java', 'javascript', 'lisp', 'lua', 'make',
            \ 'matlab', 'ocaml', 'pascal', 'perl', 'php', 'python', 'rexx',
            \ 'ruby', 'scheme', 'sh', 'slang', 'sml', 'sql', 'tcl', 'tex', 'vb',
            \ 'vera', 'verilog', 'vhdl', 'vim', 'yacc' ] }
NeoBundleLazy 'tpope/vim-dispatch', {
            \ 'commands' : [
            \   'Make', 'Make!', 'Copen', 'Copen!', 'Dispatch', 'Dispatch!',
            \   'FocusDispatch', 'FocusDispatch!', 'Start', 'Start!'
            \   ]
            \ }
NeoBundle 'tpope/vim-fugitive'
NeoBundleLazy 'tyru/open-browser.vim', {
            \ 'mappings' : [
            \  '<Plug>(openbrowser-open)',
            \  '<Plug>(openbrowser-search)',
            \  '<Plug>(openbrowser-smart-search)'
            \  ],
            \ 'commands' : 'OpenBrowserSmartSearch' }
NeoBundle 'mhinz/vim-signify'
NeoBundleLazy 'tpope/vim-vinegar', { 'filetypes' : 'netrw' }
NeoBundle 'tsukkee/unite-tag', { 'depends' : 'Shougo/unite.vim' }
NeoBundle 'scrooloose/syntastic'

" Operators:
NeoBundleLazy 'godlygeek/tabular', { 'commands' : 'Tabularize' }
NeoBundleLazy 'kana/vim-niceblock', {
            \ 'mappings' : ['<Plug>(niceblock-I)', '<Plug>(niceblock-A)' ] }
NeoBundle 'scrooloose/nerdcommenter' , {
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
            \ }
NeoBundleLazy 'tommcdo/vim-exchange', {
            \ 'mappings' : [
            \   '<Plug>(Exchange)', '<Plug>(ExchangeClear)', '<Plug>(ExchangeLine)'
            \  ]
            \ }
NeoBundleLazy 'tpope/vim-capslock',
NeoBundle 'tpope/vim-surround', {
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
            \ }

" Language Specific Syntax Handling:
NeoBundleLazy 'cypok/vim-sml',
            \ { 'filetypes' : [ 'sml', 'mosml'] }
NeoBundle 'dogrover/vim-pentadactyl'
NeoBundleLazy 'vim-scripts/TeX-PDF', { 'filetypes' : 'tex' }
NeoBundleLazy 'dbakker/vim-lint', {
            \ 'autoload' : { 'filetypes' : 'vim' },
            \ 'depends' : 'scrooloose/syntastic'
            \ }
NeoBundle 'vimez/vim-tmux', { 'filetypes' : 'conf' }

" Vim Functionality Extending:
NeoBundle 'Shougo/vimproc', {
            \ 'build' : {
            \       'windows' : 'make -f make_mingw32.mak',
            \       'cygwin'  : 'make -f make_cygwin.mak',
            \       'mac'     : 'make -f make_mac.mak',
            \       'unix'    : 'make -f make_unix.mak'
            \      },
            \ }
NeoBundleLazy 'ciaranm/securemodelines'
"NeoBundle 'kana/vim-arpeggio'
NeoBundle 'tpope/vim-repeat'
NeoBundleLazy 'merlinrebrovic/focus.vim', { 'mappings' : '<Plug>FocusModeToggle' }
NeoBundle 'dockyard/vim-easydir'
NeoBundle 'tpope/vim-rsi'
NeoBundle 'tpope/vim-unimpaired'
NeoBundleLazy 'vim-scripts/bufkill.vim', {
            \ 'commands' : [ 'BD', 'BUN', 'BW', 'BB', 'BF' ] }
NeoBundle 'ConradIrwin/vim-bracketed-paste', {
            \ 'terminal' : 1, 'disabled' : (&term !~? "xterm.*") }
NeoBundle 'ardagnir/vimbed'
NeoBundleLazy 'tpope/vim-scriptease', {
            \ 'commands' : [
            \   'PP', 'PPmsg', 'Runtime', 'Disarm', 'Scriptnames', 'Verbose',
            \   'Time', 'Breakadd', 'Breakdel', 'Vedit', 'Vsplit', 'Vopen',
            \   'Vread', 'Vvsplit', 'Vtabedit'
            \  ],
            \ 'mappings' : [
            \   '<Plug>ScripteaseFilter', '<Plug>ScripteaseFilter_',
            \   '<Plug>ScripteaseSynnames'
            \  ]
            \ }

NeoBundleCheck
filetype plugin indent on
