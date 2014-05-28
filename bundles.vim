" bundles.vim
" vim:set ft=vim tw=80 sw=4 et
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
NeoBundle 'altercation/vim-colors-solarized', { 'vim_version' : '7.2' }
NeoBundle 'bling/vim-airline'

" Text Objects:
NeoBundle 'coderifous/textobj-word-column.vim'
NeoBundle 'kana/vim-textobj-line', {
            \ 'vim_version' : '7.2',
            \ 'depends' : 'kana/vim-textobj-user'
            \ }
NeoBundle 'kana/vim-textobj-entire', {
            \ 'vim_version' : '7.2',
            \ 'depends' : 'kana/vim-textobj-user'
            \ }
NeoBundle 'michaeljsmith/vim-indent-object'
NeoBundle 'wellle/targets.vim'

" Movement:
NeoBundle 'justinmk/vim-sneak'
NeoBundle 'christoomey/vim-tmux-navigator'

" IDElike Features:
NeoBundleLazy 'Shougo/unite.vim', {
            \ 'depends' : 'Shougo/vimproc',
            \ 'autoload' : { 'commands' : 'Unite' }
            \ }
NeoBundleLazy 'benmills/vimux', {
            \ 'autoload' : {
            \   'commands' : [
            \     'VimuxPromptCommand',
            \     'VimuxInspectRunner',
            \     'VimuxRunCommand',
            \     'VimuxOpenPane'
            \     ]
            \   },
            \ 'disable' : !exists('$TMUX')
            \ }
"NeoBundleLazy 'majutsushi/tagbar', { 'autoload' : { 'filetypes' :
            "\ [ 'Ant', 'Assembler', 'ASP', 'Awk', 'Basic', 'BETA', 'C', 'C++',
            "\ 'C#', 'COBOL', 'DosBatch', 'Eiffel', 'Erlang', 'Flex', 'Fortran',
            "\ 'HTML', 'Java', 'JavaScript', 'Lisp', 'Lua', 'Make', 'MatLab',
            "\ 'OCaml', 'Pascal', 'Perl', 'PHP', 'Python', 'REXX', 'Ruby',
            "\ 'Scheme', 'Shell ''script', 'SLang', 'SML', 'SQL', 'Tcl', 'Tex',
            "\ 'Vera', 'Verilog', 'VHDL', 'Vim', 'YACC'] } }
NeoBundleLazy 'tpope/vim-dispatch', {
            \ 'autoload' : {
            \   'commands' : [
            \     'Make', 'Make!', 'Copen', 'Copen!', 'Dispatch', 'Dispatch!',
            \     'FocusDispatch', 'FocusDispatch!', 'Start', 'Start!'
            \     ]
            \   }
            \ }
NeoBundle 'tpope/vim-fugitive', { 'augroup' : 'fugitive' }
NeoBundleLazy 'tyru/open-browser.vim', {
            \ 'autoload' : {
            \         'mappings' : [
            \                 '<Plug>(openbrowser-open)',
            \                 '<Plug>(openbrowser-search)',
            \                 '<Plug>(openbrowser-smart-search)'
            \             ],
            \         'commands' : 'OpenBrowserSmartSearch'
            \      }
            \ }
NeoBundle 'mhinz/vim-signify'
NeoBundleLazy 'tpope/vim-vinegar', { 'autoload' : { 'filetypes' : 'netrw' } }
"NeoBundle 'tsukkee/unite-tag', { 'depends' : 'Shougo/unite.vim' }
NeoBundle 'scrooloose/syntastic'
NeoBundle 'valloric/YouCompleteMe', {
            \ 'build' : {
            \      'mac' : './install.sh --clang-completer',
            \      'unix' : './install.sh --clang-completer --system-libclang'
            \    }
            \ }
NeoBundle 'ntpeters/vim-better-whitespace'

" Operators:
NeoBundleLazy 'godlygeek/tabular', { 'autoload' : { 'commands' : 'Tabularize' }}
NeoBundle 'kana/vim-niceblock', { 'vim_version' : '7.3' }
NeoBundle 'scrooloose/nerdcommenter' , {
            \ 'autoload' : {
            \   'mappings' : [
            \     '<Plug>NERDCommenterComment',
            \     '<Plug>NERDCommenterNested',
            \     '<Plug>NERDCommenterToggle',
            \     '<Plug>NERDCommenterMinimal',
            \     '<Plug>NERDCommenterInvert',
            \     '<Plug>NERDCommenterSexy',
            \     '<Plug>NERDCommenterYank',
            \     '<Plug>NERDCommenterToEOL',
            \     '<Plug>NERDCommenterAppend',
            \     '<Plug>NERDCommenterInsert',
            \     '<Plug>NERDCommenterAlignLeft',
            \     '<Plug>NERDCommenterUncomment',
            \     '<Plug>NERDCommenterAlignBoth'
            \     ]
            \   }
            \ }
NeoBundleLazy 'tommcdo/vim-exchange', {
            \ 'autoload' : {
            \   'mappings' : [
            \     '<Plug>(Exchange)', '<Plug>(ExchangeClear)', '<Plug>(ExchangeLine)'
            \     ]
            \   }
            \ }
NeoBundleLazy 'tpope/vim-capslock',
NeoBundle 'tpope/vim-surround', {
            \ 'autoload' : {
            \   'mappings' : [
            \     '<Plug>Dsurround',
            \     '<Plug>Csurround',
            \     '<Plug>Ysurround',
            \     '<Plug>YSurround',
            \     '<Plug>Yssurround',
            \     '<Plug>YSsurround',
            \     '<Plug>YSsurround',
            \     '<Plug>VSurround',
            \     '<Plug>VgSurround',
            \     '<Plug>Isurround',
            \     '<Plug>ISurround',
            \     ]
            \   }
            \ }

" Language Specific:
NeoBundleLazy 'cypok/vim-sml',
            \ { 'autoload' : { 'filetypes' : [ 'sml', 'mosml'] } }
NeoBundle 'dogrover/vim-pentadactyl'
NeoBundleLazy 'vim-scripts/TeX-PDF', { 'autoload' : { 'filetypes' : 'tex' }}
NeoBundleLazy 'dbakker/vim-lint', {
            \ 'autoload' : { 'filetypes' : 'vim' },
            \ 'depends' : 'scrooloose/syntastic'
            \ }
NeoBundle 'vimez/vim-tmux', { 'autoload' : { 'filetypes' : 'conf' }}

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
NeoBundle 'kana/vim-arpeggio', { 'vim_version' : '7.2' }
NeoBundle 'tpope/vim-repeat'
NeoBundleLazy 'merlinrebrovic/focus.vim', { 'autoload' : { 'mappings' :
            \ '<Plug>FocusModeToggle' } }
NeoBundle 'dockyard/vim-easydir'
NeoBundle 'tpope/vim-rsi'
NeoBundle 'tpope/vim-unimpaired'
NeoBundleLazy 'tyru/undoclosewin.vim', { 'autoload' : {
            \ 'mappings' : '<Plug>(ucw-restore-window)' }
            \ }
NeoBundleLazy 'vim-scripts/bufkill.vim', { 'autoload' : {
            \ 'commands' : [ 'BD', 'BUN', 'BW', 'BB', 'BF' ] } }
NeoBundle 'ardagnir/eventloop.vim'
NeoBundle 'ardagnir/pterosaur'

NeoBundleCheck
filetype plugin indent on
