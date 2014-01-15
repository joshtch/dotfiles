" Clear autocmd settings -- stop autocommands from bogging down vim over time
if has("autocmd")
    autocmd!
endif

" MapLeader: needs to be set before it's used
let g:mapleader = ","

" NeoBundle Plugin Setup: {{{

" Autoinstall NeoBundle:
if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim/
    if !isdirectory(expand('~/.vim/bundle/neobundle.vim'))
        !mkdir -p ~/.vim/bundle/neobundle && git clone 'https://github.com/Shougo/neobundle.vim.git' ~/.vim/bundle/neobundle
    endif
endif

call neobundle#rc(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

" Vimproc: Asynchronous updating {{{
NeoBundle 'Shougo/vimproc', {
            \ 'build' : {
            \       'windows' : 'make -f make_mingw32.mak',
            \       'cygwin'  : 'make -f make_cygwin.mak',
            \       'mac'     : 'make -f make_mac.mak',
            \       'unix'    : 'make -f make_unix.mak'
            \      },
            \ }
" }}}

" Unite: Unified interface for file, buffer, yankstack, etc. management {{{
NeoBundle 'Shougo/unite.vim', { 'depends' : 'Shougo/vimproc' }
let g:unite_source_history_yank_enable = 1
call unite#filters#matcher_default#use(['matcher_fuzzy'])
nnoremap <Leader>ut :Unite -no-split -buffer-name=files -start-insert file_rec/async:! -resume<CR>
nnoremap <Leader>uf :Unite -no-split -buffer-name=files -start-insert file -resume<CR>
nnoremap <Leader>ur :Unite -no-split -buffer-name=mru -start-insert file_mru -resume<CR>
nnoremap <Leader>uo :Unite -no-split -buffer-name=outline -start-insert outline -resume<CR>
nnoremap <Leader>uy :Unite -no-split -buffer-name=yank history/yank -resume<CR>
nnoremap <Leader>ub :Unite -no-split -buffer-name=buffer buffer -resume<CR>
augroup UniteTags
    autocmd!
    autocmd BufEnter *
                \ if empty(&buftype)
                \| nnoremap <Buffer> <C-]> :<C-U>UniteWithCursorWord -immediately tag<CR>
                \| endif
    autocmd FileType unite nmap <buffer> <Esc> <Plug>(unite_exit)
augroup END
" Use ag if available and ignore files in .gitignore/.hgignore
if executable('ag')
    let g:unite_source_rec_async_command='ag --nocolor --nogroup --hidden -g'
endif
" }}}

" Solarized: colorscheme {{{
NeoBundle 'altercation/vim-colors-solarized', { 'vim_version' : '7.3' }
syntax enable
colorscheme solarized
call togglebg#map("<Leader>5")
let g:solarized_termcolors=16
let g:solarized_termtrans=0
" }}}

" Vimux: Interact with a tmux split directly from vim's commandline {{{
NeoBundle 'benmills/vimux'
nnoremap <Leader>vs :call VimuxRunCommand('exec zsh')<CR>:call VimuxRunCommand('clear')<CR>
nnoremap <Leader>vc :VimuxCloseRunner<CR>
nnoremap <Leader>vp :VimuxPromptCommand<CR>
nnoremap <Leader>vr :VimuxRunLastCommand<CR>
" }}}

" vim-airline statusline {{{
NeoBundle 'bling/vim-airline'
silent! set guifont=Inconsolata-dz\ for\ Powerline\ 12
set lazyredraw
set t_Co=256
set ttimeoutlen=50
let g:airline_powerline_fonts = 1
let g:airline_enable_synastic = 1
let g:airline_enable_fugitive = 1
let g:airline_modified_detection = 1
"let g:airline_left_sep = '▶'
"let g:airline_right_sep = '◀'
"let g:airline_linecolumn_prefix = '¶'
"let g:airline_fugitive_prefix = '⎇ '
let g:airline_theme = 'solarized'
let g:airline#extensions#tabline#enabled = 1
" }}}

" VimTmuxNavigator: Seamlessly navigate vim and tmux splits {{{
NeoBundle 'christoomey/vim-tmux-navigator'
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <C-H> :TmuxNavigateLeft<CR>
nnoremap <silent> <C-J> :TmuxNavigateDown<CR>
nnoremap <silent> <C-K> :TmuxNavigateUp<CR>
nnoremap <silent> <C-L> :TmuxNavigateRight<CR>
nnoremap <silent> <C--> :TmuxNavigatePrevious<CR>
" }}}

" Allow user to undo with `u` after using <C-U>
" Vim_lint: Syntax checking for vimscript
NeoBundle 'dbakker/vim-lint', { 'depends' : 'scrooloose/syntastic' }

" Tabular: Character alignment {{{
NeoBundle 'godlygeek/tabular'
if exists(":Tabularize")
    nnoremap <Leader>a= :Tabularize /=<CR>
    xnoremap <Leader>a= :Tabularize /=<CR>
    nnoremap <Leader>a: :Tabularize /:\zs<CR>
    xnoremap <Leader>a: :Tabularize /:\zs<CR>

    " Tabular operator function
    " Operations have the form <MAPPING> <TEXTOBJECT> <ALIGNMENT CHAR>
    " For example, to align a paragraph along '=' chars, do <Leader>tip=
    function! s:tabularize_op(type, ...)
        let c = nr2char(getchar())
        execute "'[,']Tabularize/".c
    endfunction
    nnoremap <silent> <Leader>t :set opfunc=<SID>tabularize_op<Enter>g@
endif
" }}}

" Unite_outline: Outlining in unite
NeoBundle 'h1mesuke/unite-outline', { 'depends' : 'Shougo/unite.vim' }

" Vim Snippets: Default snippets for various languages
NeoBundle 'honza/vim-snippets'
NeoBundle 'MarcWeber/ultisnips'

" Arpeggio: Chord arbitrary keys together (e.g. 'jk' to esc) {{{
NeoBundle 'kana/vim-arpeggio', { 'vim_version' : '7.2' }
augroup Arpeggio
    autocmd!
    autocmd VimEnter * Arpeggio inoremap jk <Esc>
augroup END
" }}}

" Niceblock: Use I and A in all visual modes, not just visual block mode
NeoBundle 'kana/vim-niceblock', { 'vim_version' : '7.3' }

" Operator User: Create your own operators {{{
NeoBundle 'kana/vim-operator-user', { 'vim_version' : '7.2' }

" Operator Edge: Insert before/append after a text object/visual selection {{{
" Note: requires +ex_extra
" TODO: Make this operator work with tpope's repeat.vim
"    See https://github.com/tpope/vim-repeat/issues/8
" TODO: Separate this into its own repository and post on github

map ( <Plug>(operator-edge-insert)
map ) <Plug>(operator-edge-append)
call operator#user#define('edge-insert', 'Op_command_insert')
call operator#user#define('edge-append', 'Op_command_append')

function! Op_command_insert(motion_wise)
    normal! `[
    if a:motion_wise != "char"
        normal! O
    endif
    startinsert
endfunction

function! Op_command_append(motion_wise)
    normal! `]
    if a:motion_wise != "char"
        normal! o
    endif
    let s:init_col = virtcol(".")
    normal! l
    " Since there's no "startappend", we have two cases to check
    if virtcol(".") == s:init_col
        startinsert!
    else
        startinsert
    endif
endfunction

silent! call repeat#set("\<Plug>(operator-edge-insert)",v:count)
silent! call repeat#set("\<Plug>(operator-edge-append)",v:count)
" }}}

" }}}

" Bufkill: Close buffers without closing windows
NeoBundle 'mattdbridges/bufkill.vim'

" Signify: Show VCS diff using sign column
"NeoBundle 'mhinz/vim-signify'

" Focus: Force display of a single buffer for focused editing {{{
" This mapping is included to keep focus.vim from setting its own
silent! nmap <Leader>f <Plug>FocusModeToggle
NeoBundle 'merlinrebrovic/focus.vim', {
            \ 'stay_same' : 0,
            \ 'mappings' : '<Plug>FocusModeToggle'
            \ }
function! CleanEmptyBuffers()
    let buffers = filter(range(0, bufnr('$')), 'buflisted(v:val) && empty(bufname(v:val)) && bufwinnr(v:val)<0')
    if !empty(buffers)
        exe 'bw '.join(buffers, ' ')
    endif
endfunction
nmap <silent> <Leader>f <Plug>FocusModeToggle:call CleanEmptyBuffers()<CR>
" }}}

" Ag Vim: Ag plugin for vim
NeoBundle 'rking/ag.vim'

" Syntastic: Real-time syntax checking {{{
NeoBundle 'scrooloose/syntastic'
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_filetype_map = { 'latex': 'tex' }
let g:syntastic_stl_format = '[%E{Err: %fe #%e}]'
let g:syntastic_list_height = 5
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '!'
let g:syntastic_c_check_header = 1
"let g:syntastic_auto_refresh_includes = 1
let g:syntastic_c_compiler = 'gcc'
" }}}

" NERDCommenter: Smart commenting plugin {{{
NeoBundle 'scrooloose/nerdcommenter'
" }}}

" Gundo: Undo tree visualization {{{
NeoBundle 'sjl/gundo.vim', {
            \ 'vim_version' : '7.3',
            \ 'disabled' : '!has("python")'
            \ }
nnoremap <Leader>g :GundoToggle<CR>
" }}}

" Vim_space: Repeat motions with space
NeoBundle 'spiiph/vim-space'

" Easymotion: Quick navigation with hotkeys {{{
NeoBundle 'supasorn/vim-easymotion'
let g:EasyMotion_leader_key = '\'
hi EasyMotionTarget ctermbg=none ctermfg=red
hi EasyMotionTarget2First ctermbg=none ctermfg=red
hi link EasyMotionShade Comment
" }}}

" Capslock: Enable capslock for only insert mode using <C-G>c
NeoBundle 'tpope/vim-capslock'

" Dispatch: Asyncronous compiling with tmux/screen/iterm
NeoBundle 'tpope/vim-dispatch'

" Fugitive: Awesome git plugin for vim {{{
NeoBundle 'tpope/vim-fugitive', { 'augroup' : 'fugitive' }
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gc :Gcommit<CR>
nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>gl :Glog<CR>
nnoremap <Leader>gp :Git push<CR>
nnoremap <Leader>gs :Git status -sb<CR>
" }}}

" Capslock: Enable capslock for only insert mode using <C-G>c
NeoBundle 'tpope/vim-capslock'

" Repeat: Enable use of dot operator with certain plugins
NeoBundle 'tpope/vim-repeat'

" RSI: Readline key bindings for insert and command line modes
NeoBundle 'tpope/vim-rsi'

" Surround: Surround text easily
NeoBundle 'tpope/vim-surround'

" Easydir: Automatically create filepaths for :w, :e, etc if they don't exist
NeoBundle 'dockyard/vim-easydir'

" Tag: Tag navigation in unite
NeoBundle 'tsukkee/unite-tag', { 'depends' : 'Shougo/unite.vim' }

" Open Browser: Open a URL in the default browser {{{
NeoBundle 'tyru/open-browser.vim', {
            \ 'mappings' : '<Plug>(openbrowser-open),<Plug>(openbrowser-smart-search)'
            \ }
map gu <Plug>(openbrowser-open)
map gs <Plug>(openbrowser-search)
map go <Plug>(openbrowser-smart-search)
nnoremap <Leader>ob :OpenBrowserSmartSearch<Space>
" }}}

" UndoCloseWin: Undo closing of tabs and windows {{{
NeoBundle 'tyru/undoclosewin.vim', {
            \ 'mappings' : '<Plug>(ucw-restore-window)'
            \ }
map <Leader>br <Plug>(ucw-restore-window)
" }}}

" YouCompleteMe: Smart autocompletion {{{
NeoBundle 'Valloric/YouCompleteMe', {
            \ 'disabled' : '!has("python") || !has("unix")',
            \ 'vim_version' : '7.3.584',
            \ 'build' : {
            \       'unix' : '~/.vim/bundle/YouCompleteMe/install.sh',
            \       'mac' : '~/.vim/bundle/YouCompleteMe/install.sh',
            \     }
            \ }
let g:ycm_confirm_extra_conf = 0
let g:ycm_key_detailed_diagnostics = ''
let g:ycm_register_as_syntastic_checker = 0
" }}}

" Holylight: (OSX only) Autoswap between light and dark colorscheme {{{
" based on ambient light level
NeoBundle 'Dinduks/vim-holylight', {
            \ 'disabled' : '!has("unix") || system("uname") != "Darwin\n"'
            \ }
" }}}

" Custom Textobjects: {{{
NeoBundle 'kana/vim-textobj-user', { 'vim_version' : '7.0' }

" Indentation: textobject ('ii', 'ai', 'iI', and 'aI')
" i vs a: empty lines (not included/included)
" i vs I: more indents (included/not included)
NeoBundle 'michaeljsmith/vim-indent-object'

" Full Buffer: textobject ('ie' and 'ae')
NeoBundle 'kana/vim-textobj-entire', {
            \ 'vim_version' : '7.2',
            \ 'depends' : 'kana/vim-textobj-user'
            \ }

" Line: textobject ('il' and 'al')
NeoBundle 'kana/vim-textobj-line', {
            \ 'vim_version' : '7.2',
            \ 'depends' : 'kana/vim-textobj-user'
            \ }

" Underscore: textobject ('i_'/'a_') -- for snake_case_objects
NeoBundle 'kana/vim-textobj-underscore', {
            \ 'vim_version' : '7.2',
            \ 'depends' : 'kana/vim-textobj-user'
            \ }

" Columns: textobject ('ic'/'ac', and 'iC'/'aC') (difference is word vs WORD)
NeoBundle 'coderifous/textobj-word-column.vim', {
            \ 'vim_version' : '7.2',
            \ 'depends' : 'kana/vim-textobj-user'
            \ }

" }}}

" Disabled Plugins: {{{
"NeoBundle 'ksenoy/vim-signature'
"NeoBundle 'osyo-manga/vim-over'
"NeoBundle 'tpope/vim-obsession'
" }}}

NeoBundleCheck
" }}}

" Autolabel tmux windows
augroup Tmux
    autocmd!
    autocmd VimEnter,BufNewFile,BufReadPost * call system('tmux rename-window "vim - ' . split(substitute(getcwd(), $HOME, '~', ''), '/')[-1] . '"')
    autocmd VimLeave * call system('tmux rename-window ' . split(substitute(getcwd(), $HOME, '~', ''), '/')[-1])
augroup END

" Open help in a vertical split instead of the default horizontal split
" " http://vim.wikia.com/wiki/Replace_a_builtin_command_using_cabbrev
cabbrev h <C-R>=(getcmdtype()==':' && getcmdpos()==1 ? 'vert h' : 'h')<CR>
cabbrev help <C-R>=(getcmdtype()==':' && getcmdpos()==1 ? 'vert h' : 'help')<CR>

" Toggle Vexplore with Ctrl-E {{{
" Still haven't jumped on the NerdTree bandwagon
function! ToggleVExplorer()
    if exists("t:expl_buf_num")
        let expl_win_num = bufwinnr(t:expl_buf_num)
        if expl_win_num != -1
            let cur_win_nr = winnr()
            exec expl_win_num . 'wincmd w'
            close
            exec cur_win_nr . 'wincmd w'
            unlet t:expl_buf_num
        else
            unlet t:expl_buf_num
        endif
    else
        exec '1wincmd w'
        Vexplore
        vert res -70
        let t:expl_buf_num = bufnr("%")
    endif
endfunction
noremap <silent> <C-E> :call ToggleVExplorer()<CR>
" Hit enter in the file browser to open the selected
" file with :vsplit to the right of the browser.
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_liststyle = 3
let g:netrw_retmap = 1
let g:netrw_browse_split = 2
" Change directory to the current buffer when opening files.
set autochdir
" }}}

" Allow quitting unnamed buffers without confirmation or ! {{{
nnoremap <Leader>q :call QuitIfEmpty()<CR>:q<CR>
function! QuitIfEmpty()
    if empty(bufname('%'))
        setlocal nomodified
    endif
endfunction
" }}}

" Replace 'ddate' with the current date in insert mode
if exists("*strftime")
    iabbrev ddate <C-R>=strftime("%m/%d/%Y")<CR>
    iabbrev ttime <C-R>=strftime("%Y-%m-%d %a %H:%M")<CR>
endif

" Allow backspacing anywhere
set backspace=indent,eol,start

" Split windows below and to the right by default
set splitbelow
set splitright

" cmdline tab completion settings
set wildmode=list:longest,full
set wildmenu
" Don't try to open archives, swapfiles, or binaries
set wildignore=*.o,*~,*.pyc,*.obj,*.a,*.lib,*.elf

" Command bar appearance modifications
set showcmd
set showmode
set cmdheight=1
set shortmess=atIfilmnrxoOT

" Highlight screen line of the cursor, but only in current window
augroup CursorLine
    autocmd!
    au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
augroup END

" Always show line numbers, but only in current window.
augroup ShowLineNumber
    autocmd!
    set number
    au WinEnter * setlocal number
    au WinLeave * setlocal nonumber
augroup END

" Insert completion
set completeopt=longest,menuone  " Display longest match, menu
set infercase                    " Infer the case of match

" Parenthesis matching
set showmatch    " Show matching parens
set matchtime=1  " Tenths of a second to show matching paren

" Defines bases for numbers for <C-A> and <C-X>
set nrformats=hex,alpha

" Allow modified buffers to be hidden
set hidden

" Search settings
set incsearch " Show results of search immediately
set hlsearch  " Highlight search results by default
set magic     " Use regexp-style search; 'magic' is default

" Use 'verymagic' when searching. Does not verymagic substitutions; if you
" want to verymagic your substitutions, add the flag yourself, or use the
" last search register
" TODO: Make substitutions automatically verymagic without breaking things
nnoremap / /\v

" Case matching in search
set ignorecase " Ignore case in search patterns
set smartcase  " Does not ignore case if search contains caps

" Show comma-separated line and column location
set ruler

" Number of spaces that a <Tab> in the file counts for
set tabstop=4

" Number of spaces that a <Tab> counts for for >>, <<, etc
set softtabstop=4

" Tabbing settings
set shiftwidth=4 " Number of spaces to tab by
set expandtab    " Change <Tab>s to spaces
set smarttab     " Tab inserts shiftwidth spaces, and backspace
set shiftround   " Round indents to multiple of 'shiftwidth'

" Disable temp and backup files
set wildignore+=*.swp,*~,._*
set nobackup
set noswapfile

" Smart autoindenting
set autoindent
set cindent
"set smartindent " -- Deprecated
filetype plugin indent on

" Make trailing whitespace annoyingly highlighted.
" See: http://vim.wikia.com/wiki/Highlight_unwanted_spaces
" TODO: Turn this off for markdown and other languages that require trailing ws
augroup AnnoyingWhitespace
    autocmd!
    highlight link ExtraWhitespace ErrorMsg
    match ExtraWhitespace /\s\+$/
    autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
    autocmd InsertEnter * match ExtraWhitespace /\v\s+%#@<!$/
    autocmd InsertLeave * match ExtraWhitespace /\s\+$/
    autocmd BufWinLeave * call clearmatches()
    autocmd InsertEnter *
                \ syn clear EOLWS | syn match EOLWS excludenl /\v\s+%#@!$/
    autocmd InsertLeave *
                \ syn clear EOLWS | syn match EOLWS excludenl /\s\+$/
    highlight link EOLWS ErrorMsg
augroup END

" Set default shell to use
set shell=/bin/zsh

" Show tab characters
set list
set listchars=tab:▶\ ,
"set listchars+=trail:·

" Allow use of mouse
set mouse=a
" For xterm2 mouse support
set ttymouse=xterm2

" Text wrapping
set nowrap    " Disallow (soft)wrapping of text
set linebreak " Break lines at convenient points
set textwidth=80

" Supported document formats
set encoding=utf8
set fileformats=unix,dos,mac

" Fold management
set foldmethod=marker
set foldnestmax=3
set nofoldenable
set foldcolumn=1

" Scrolling boundaries
set scrolloff=4
set sidescrolloff=0

" Swap file is written after this many characters
" 0 = no swap
set updatecount=0
" Disable backing up before overwriting a file
set nobackup
set nowritebackup

" Show line numbers
set number

" Add a relative number toggle
nnoremap <Leader>r :set rnu!<CR>

" Rereads a file when it is detected to have been modified outside Vim
set autoread

" Automatically save file when focus is lost
set autowrite

" Autoindent imitates indenting of previous line's indent
set copyindent

" Off to avoid security vulnerabilities
set modelines=0
set secure

" See :help slow-terminal
" Optimize for fast terminal connections
set ttyfast
" Time out on key codes but not mappings
set notimeout
set ttimeout
set ttimeoutlen=100
" Update syntax highlighting for more lines increased scrolling performance
syntax sync minlines=256
" Don't syntax highlight long lines
set synmaxcol=256
" Don't redraw screen while executing macros, registers
" set lazyredraw
" Maximum number of lines to scroll the screen
" ttyscroll=3
" Jump by more lines when scrolling
" set scrolljump=2

" Allow redo for insert-mode ^u
inoremap <C-U> <C-G>u<C-U>

" Since the ',' command is actually useful, set it to ',,'
nnoremap <Leader>, ,
nnoremap <silent> <Leader>/ :nohlsearch<CR>
nnoremap <Leader>w :w!<CR>
nnoremap <silent> <Leader>ev :vsplit $MYVIMRC<CR>
nnoremap <silent> <Leader>ep :vsplit ~/dotfiles/plugins.vim<CR>
nnoremap <silent> <Leader>ez :vsplit ~/.zshrc<CR>
nnoremap <silent> <Leader>sl ^vg_y:execute @@<CR>
nnoremap <silent> <Leader>ea :vsplit ~/.oh-my-zsh/lib/aliases.zsh<CR>
nnoremap <silent> <Leader>sv :so $MYVIMRC<CR>

" Toggle paste mode with <Leader>p
nnoremap <silent> <Leader>p :set paste!<CR>

" Open a Quickfix window for the last search.
nnoremap <silent> <Leader>? :execute 'vimgrep /'.@/.'/g %'<CR>:copen<CR>

" Delete to black hole register
nnoremap <silent> <Leader>d "_d

" Switch buffers with a count: 3! with switch to buffer 3
" Delete buffers the same way with ~
nnoremap <expr> ! v:count ? ":<C-U>b<C-R>=v:count<CR><CR>" : "!"
nnoremap <expr> ~ v:count ? ":<C-U>bd<C-R>=v:count<CR><CR>" : "~"

" Use the first open window that contains the specified buffer
set switchbuf=useopen

" Gvim-specific settings
" This really should go in its own .gvimrc
if has("gui_running")
    set guioptions-=T
    set guioptions+=e
    set guitablabel=%M\ %t
    " Remove small delay between pressing Esc and entering Normal mode.
    set ttimeoutlen=10
    augroup FastEscape
        autocmd!
        au InsertEnter * set timeoutlen=0
        au InsertLeave * set timeoutlen=1000
    augroup END
endif

" Only do this part when compiled with support for autocommands
if has("autocmd")
    " Enable file type detection
    filetype on

    augroup filetype_commands
        autocmd!
        " Syntax of these languages is fussy over tabs Vs spaces
        autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
        autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

        " Customisations based on house-style (arbitrary)
        autocmd FileType html setlocal ts=8 sts=4 sw=4 expandtab
        autocmd FileType css setlocal ts=8 sts=4 sw=4 expandtab
        autocmd FileType javascript setlocal ts=4 sts=4 sw=4 noexpandtab
        autocmd FileType c setlocal ts=4 sts=4 sw=4 cindent expandtab

        " Treat .rss files as XML
        autocmd BufNewFile,BufRead *.rss setfiletype xml
    augroup END
endif

" Highlight column 80 so we know when we're over
if exists('+colorcolumn')
    set colorcolumn=80
else
    highlight OverLength ctermbg=darkred ctermfg=white guibg=#FFD9D9
    match OverLength /\%>80v.\+/
endif

" Delete comment character when joining commented lines
if v:version > 703 || v:version == 703 && has("patch541")
    set formatoptions+=j
endif

" Use the more intuitive + and - for incrementing and decrementing numbers
nnoremap + <C-A>
nnoremap - <C-X>

" Set Y to match C and D syntax (use yy to yank entire line)
nnoremap Y y$

" Aesthetics
"set title
set viewoptions=folds,options,cursor,unix,slash
set laststatus=2 " Always display status line

" No annoying alerts -- off by default, but just to be sure
set noerrorbells
set novisualbell

" Things to remember between sessions
" '20  - remember marks for 20 previous files
" \"10 - save 10 lines for each register
" :10  - remember 20 items in command-line history
" /10  - remember 20 items in search history
" %    - remember the buffer list (if vim started without a file arg)
" n    - set name of viminfo file
set viminfo='20,\"50,:10,/10,%,n~/.viminfo

" Remember undo history
" This will store your undo information in your current directory in .vim-undo
"  if you have that directory. Handy if you want the undo info to not be
"  available elsewhere (say, in an encrypted disk). Otherwise it'll store it
"  in ~/.vim-undo/
" This, like swap and backups, uses .vim-undo first, then ~/.vim/undo
" This is only present in 7.3+
if exists("+undofile")
    if isdirectory($HOME . '/.vim/undo') == 0
        silent !mkdir -p ~/.vim/undo > /dev/null 2>&1
    endif
    set undodir=./.vim-undo//
    set undodir+=~/.vim/undo//
    set undofile
    set undolevels=100  " How many undos to save
    set undoreload=1000 " Number of lines to save per undo
endif

" Remember cursor position
function! ResCur()
    if line("'\"") <= line("$")
        normal! g`"
        return 1
    endif
endfunction
augroup resCur
    autocmd!
    autocmd BufWinEnter * call ResCur()
augroup END

" Define what to save with :mksession
" blank - empty windows
" buffers - all buffers not only ones in a window
" curdir - the current directory
" folds - including manually created ones
" help - the help window
" options - all options and mapping
" winsize - window sizes
" tabpages - all tab pages
set sessionoptions=blank,buffers,curdir,folds,help,options,winsize,tabpages

" Makes windows always equal size when resizing
set equalalways
augroup Resize
    autocmd!
    au VimResized * exe "normal! \<C-W>="
augroup END

" Sets minimum split width -- 80 + 4 for number column
set winwidth=84

" Put visually selected text in the '*' (middleclick/mouse) register and
" '+' (global clipboard) register by default; may not work perfectly on linux
set clipboard=unnamed,unnamedplus

" Map annoying and useless <F1>, Q and K to more useful things
" F1 clears search highlighting and refreshes, Q repeats last macro, K splits
" the line and removes trailing whitespace (reverse of J/gJ)
nnoremap <F1> <Nop>
nnoremap Q @q
nnoremap K i<CR><Esc>k:let _s=@/<CR>:s/\s\+$//e<CR>:let @/=_s<CR>$
set nojoinspaces
noremap L }
noremap H {
noremap { ^
noremap } $

" Nice way to scroll page by page
nnoremap <Leader>j z+
nnoremap <Leader>k z^

" Allow expected behavior when traversing wrapped lines
noremap j gj
noremap k gk
noremap gj j
noremap gk k

function! <SID>StripTrailingWhitespace()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
nnoremap <silent> <Leader>cws :call <SID>StripTrailingWhitespace()<CR>

if $TERM_PROGRAM == 'iTerm.app'
" different cursors for insert vs normal mode
    if exists('$TMUX')
        let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
        let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
    else
        let &t_SI = "\<Esc>]50;CursorShape=1\x7"
        let &t_EI = "\<Esc>]50;CursorShape=0\x7"
    endif
endif
