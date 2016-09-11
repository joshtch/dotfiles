if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

" Conditional Activation helper function for Plug
function! Cond(cond, ...)
  let opts = get(a:000, 0, {})
  return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

call plug#begin('~/.vim/bundle/')

" Appearance:
Plug 'altercation/vim-colors-solarized'
Plug 'bling/vim-airline'
    \| Plug 'vim-airline/vim-airline-themes'

" Text Objects:
Plug 'coderifous/textobj-word-column.vim'
Plug 'kana/vim-textobj-user'
    \| Plug 'kana/vim-textobj-line'
    \| Plug 'kana/vim-textobj-entire'
Plug 'michaeljsmith/vim-indent-object'
"Plug 'wellle/targets.vim'

" Movement:
Plug 'christoomey/vim-tmux-navigator'
Plug 'unblevable/quick-scope'

" IDElike Features:
"Plug 'SirVer/ultisnips'
    "\| Plug 'honza/vim-snippets'
Plug 'majutsushi/tagbar', { 'for' : [
            \ 'ant', 'asm', 'asp', 'awk', 'basic', 'beta', 'c',
            \ 'cpp', 'csharp', 'cobol', 'bat', 'eiffel', 'erlang', 'flex',
            \ 'fortran', 'html', 'java', 'javascript', 'lisp', 'lua', 'make',
            \ 'matlab', 'ocaml', 'pascal', 'perl', 'php', 'python', 'rexx',
            \ 'ruby', 'scheme', 'sh', 'slang', 'sml', 'sql', 'tcl', 'tex', 'vb',
            \ 'vera', 'verilog', 'vhdl', 'vim', 'yacc' ] }
Plug 'tpope/vim-dispatch', { 'on' : [
            \ 'Make', 'Copen', 'Dispatch', 'FocusDispatch', 'Start' ] }
Plug 'tpope/vim-fugitive'
Plug 'tyru/open-browser.vim', { 'on' : [
            \ '<Plug>(openbrowser-open)', '<Plug>(openbrowser-search)',
            \ '<Plug>(openbrowser-smart-search)' ] }
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-vinegar', { 'for': 'netrw' }
Plug 'scrooloose/syntastic'
    \| Plug 'dbakker/vim-lint', { 'for' : 'vim' }
Plug 'zweifisch/pipe2eval'

"function! BuildVimProc(info)
    "if a:info.status == 'installed' || a:info.force
        "if has('cygwin')
            "execute '!' . shellescape('./make') . ' -f make_cygwin.mak'
        "elseif has('windows')
            "execute '!' . shellescape('./make') . ' -f make_mingw32.mak'
        "elseif has('mac')
            "execute '!' . shellescape('./make') . ' -f make_mac.mak'
        "elseif has('unix')
            "execute '!' . shellescape('./make') . ' -f make_unix.mak'
        "endif
    "endif
"endfunction
"Plug 'Shougo/vimproc', { 'do' : function('BuildVimproc') }
    "\| Plug 'Shougo/unite.vim', { 'on' : 'Unite' }
    "\| Plug 'tsukkee/unite-tag'
    "\| Plug 'Shougo/neomru.vim'

" Operators:
Plug 'godlygeek/tabular', { 'on': [ 'Tab', 'Tabularize' ] }
Plug 'kana/vim-niceblock', { 'on' : [
            \ '<Plug>(niceblock-I)', '<Plug>(niceblock-A)' ] }
Plug 'scrooloose/nerdcommenter' , { 'on' : [
            \   '<Plug>NerdCommenterComment',
            \   '<Plug>NerdCommenterNested',
            \   '<Plug>NerdCommenterToggle',
            \   '<Plug>NerdCommenterMinimal',
            \   '<Plug>NerdCommenterInvert',
            \   '<Plug>NerdCommenterSexy',
            \   '<Plug>NerdCommenterYank',
            \   '<Plug>NerdCommenterToEol',
            \   '<Plug>NerdCommenterAppend',
            \   '<Plug>NerdCommenterInsert',
            \   '<Plug>NerdCommenterAlignleft',
            \   '<Plug>NerdCommenterUncomment',
            \   '<Plug>NerdCommenterAlignboth'
            \   ]
            \ }
Plug 'tommcdo/vim-exchange', { 'on':  [
            \   '<Plug>(Exchange)', '<Plug>(ExchangeClear)', '<Plug>(ExchangeLine)'
            \  ] }
Plug 'tpope/vim-capslock', { 'on' : '<Plug>CapsLockToggle' }
Plug 'tpope/vim-surround', { 'on' : [
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
            \  ] }

" Language Specific Syntax Handling:
Plug 'vim-scripts/TeX-PDF', { 'for' : 'tex' }
Plug 'vimez/vim-tmux', { 'for' : 'conf' }
Plug 'vim-pandoc/vim-pandoc'
            \| Plug 'vim-pandoc/vim-pandoc-syntax', { 'for': 'pandoc' }
Plug 'nelstrom/vim-markdown-folding', { 'for': 'markdown' }

" Vim Functionality Extending:
Plug 'ciaranm/securemodelines'
Plug 'tpope/vim-repeat'
Plug 'merlinrebrovic/focus.vim', { 'on' : '<Plug>FocusModeToggle' }
Plug 'dockyard/vim-easydir'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-unimpaired'
Plug 'vim-scripts/bufkill.vim', { 'on': [ 'BD', 'BUN', 'BW', 'BB', 'BF' ] }
Plug 'ConradIrwin/vim-bracketed-paste', Cond(&term =~? 'xterm.*')
Plug 'tpope/vim-scriptease', { 'on': [
            \   'PP', 'PPmsg', 'Runtime', 'Disarm', 'Scriptnames', 'Verbose',
            \   'Time', 'Breakadd', 'Breakdel', 'Vedit', 'Vsplit', 'Vopen',
            \   'Vread', 'Vvsplit', 'Vtabedit',
            \   '<Plug>ScripteaseFilter', '<Plug>ScripteaseFilter_',
            \   '<Plug>ScripteaseSynnames'
            \  ] }

call plug#end()
