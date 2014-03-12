" vimrc
" vim:set ft=vim tw=80 sw=4 et

" Clear autocmd settings -- stop autocommands from bogging down vim over time
if has("autocmd")
    autocmd!
endif

" MapLeader: needs to be set before it's used
let g:mapleader = ","

" Plugins And Settings:
source ~/dotfiles/bundles.vim
source ~/dotfiles/plugins.vim

" Open help in a vertical split instead of the default horizontal split
" " http://vim.wikia.com/wiki/Replace_a_builtin_command_using_cabbrev
cabbrev h <C-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'vert h' : 'h')<CR>
cabbrev help <C-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'vert h' : 'help')<CR>

" Use ,q to quit empty buffers without confirmation or !
nnoremap <silent> <Leader>q :<C-u>call QuitIfEmpty()<CR>:q<CR>
function! QuitIfEmpty()
    if empty(bufname('%'))
        setlocal nomodified
    endif
endfunction

" Replace 'ddate' with current date, 'ttime' with current time
if exists("*strftime")
    iabbrev ddate <C-r>=strftime("%m/%d/%Y")<CR>
    iabbrev ttime <C-r>=strftime("%Y-%m-%d %a %H:%M")<CR>
endif

" Allow backspacing anywhere
set backspace=indent,eol,start

" Split windows below and to the right by default
set splitbelow
set splitright

" cmdline tab completion settings
set wildmenu
set wildmode=list:longest,full
" Don't try to open archives, swapfiles, or binaries
set wildignore=*.o,*~,*.pyc,*.obj,*.a,*.lib,*.elf
set complete-=i  " Ignore included files

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

" Defines bases for numbers for <C-a> and <C-x>
set nrformats=hex,alpha

" Allow modified buffers to be hidden
set hidden

" Search settings
set incsearch       " Show results of search immediately
set hlsearch        " Highlight search results by default
set magic           " Use regexp-style search; 'magic' is default
set wrapscan        " Have search wrap around the end of file

" These improve the C-style /* comments by wrapping with
" a ' *' on each line.
" /*
" * So that your
" * multiline comments
" * look like this
" */
set comments-=s1:/*,mb:*,ex:*/
set comments+=s:/*,mb:\ *,ex:\ */
set comments+=fb:*

" Use 'verymagic' search. Does not apply to substitutions; if you want to
" verymagic your substitutions, use the last search register
" TODO: Make substitutions automatically verymagic without breaking things, make
" using previous search easier (currently: "/<BS><BS>/")
nnoremap / /\v

" Auto center long jumps
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz
nnoremap <silent> g# g#zz
nnoremap <silent> <C-o> <C-o>zz
nnoremap <silent> <C-i> <C-i>zz

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

"set smartindent " -- Deprecated
filetype plugin indent on

" Set default shell to use
set shell=/bin/zsh

" Show tab characters
"set list
"set listchars=tab:▶\ ,
"set listchars+=trail:·

set mouse=a         " Allow use of mouse
set ttymouse=xterm2 " For xterm2 mouse support

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
set foldcolumn=0

" Vimdiff settings
set diffopt=filler,vertical,foldcolumn:2

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
nnoremap <Leader>r :<C-u>set rnu!<CR>

" Rereads a file when it is detected to have been modified outside Vim
set autoread

" Automatically save file when focus is lost
set autowrite

" Imitate indenting of previous line's indent
set copyindent
set autoindent

" Newline without automatically adding leading characters (e.g. comment chars)
inoremap <C-j> <CR><C-u>

" See :help slow-terminal
" Optimize for fast terminal connections
set ttyfast
" Time out on key codes but not mappings
set notimeout
set ttimeout
" Update syntax highlighting for more lines increased scrolling performance
syntax sync minlines=256
" Don't syntax highlight long lines
set synmaxcol=256
" Don't redraw screen while executing macros, registers
" set lazyredraw
" Maximum number of lines to scroll the screen
" set ttyscroll=3
" Jump by more lines when scrolling
" set scrolljump=2

" Allow redo for insert mode ^u
inoremap <C-u> <C-g>u<C-u>

" Since the ',' command is actually useful, set it to ',,'
nnoremap <Leader>, ,
nnoremap <silent> <Leader>/ :<C-u>nohlsearch<CR>
nnoremap <Leader>w :<C-u>w!<CR>
nnoremap <silent> <Leader>ev :<C-u>vsplit $MYVIMRC<CR>
nnoremap <silent> <Leader>ep :<C-u>vsplit ~/dotfiles/plugins.vim<CR>
nnoremap <silent> <Leader>ez :<C-u>vsplit ~/.zshrc<CR>
nnoremap <silent> <Leader>sl ^vg_y:execute @@<CR>
nnoremap <silent> <Leader>ea :<C-u>vsplit ~/.oh-my-zsh/lib/aliases.zsh<CR>
nnoremap <silent> <Leader>sv :<C-u>so $MYVIMRC<CR>

" Toggle paste mode with <Leader>p
set pastetoggle=<Leader>p
nnoremap <silent> <Leader>p :<C-u>set paste!<CR>

" Open a Quickfix window for the last search.
nnoremap <silent> <Leader>? :execute 'vimgrep /'.@/.'/g %'<CR>:copen<CR>

" Delete to black hole register
nnoremap <silent> <Leader>d "_d

" Switch buffers with a count: 3! with switch to buffer 3
" Delete buffers the same way with ~
nnoremap <expr> ! v:count ? ":<C-u>b<C-r>=v:count<CR><CR>" : "!"
nnoremap <expr> ~ v:count ? ":<C-u>bd<C-r>=v:count<CR><CR>" : "~"

" Use the first open window that contains the specified buffer
set switchbuf=useopen

" Gvim-specific settings
" This really should go in its own .gvimrc
if has("gui_running")
    set guioptions=c
    silent! set guifont=Inconsolata-dz\ for\ Powerline\ 12
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
        au FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
        au FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

        " Customisations based on house-style (arbitrary)
        au FileType html       setlocal ts=8 sts=4 sw=4 expandtab
        au FileType css        setlocal ts=8 sts=4 sw=4 expandtab
        au FileType javascript setlocal ts=4 sts=4 sw=4 noexpandtab
        au FileType c          setlocal ts=4 sts=4 sw=4 expandtab
        au FileType c,cpp,javascript,slang setlocal cindent fo+=ro
        au FileType bash,coffee,markdown,python,zsh set sw=4 ts=4 expandtab
        au FileType javascript,html,xhtml,css,php set sw=2 tw=2 fdm=indent

        " Fix syntax highlighting of vim helpfiles, since 'modeline' is off
        au BufEnter *.txt
            \ if expand('%:p:h') =~ '.*/\.\?vim/.*/doc' | set ft=help | endif

        " Treat ImpCore as Scheme (Comp105)
        au BufNewFile,BufRead *.imp,*.ic setfiletype scheme

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

" Settings for automatic text formatting
 set formatoptions=
 set fo+=t " Auto-wrap text using 'textwidth'
 set fo+=c " Auto-wrap comments + autoinsert comment leader
 set fo+=r " Insert current comment leader after hitting <CR>
"set fo+=o " Insert current comment leader after hitting 'o' or 'O'
 set fo+=q " Allow formatting with 'gq'
"set fo+=w " Trailing white space indicates a paragraph continues
"set fo+=a " Autoformat paragraphs every time text is inserted/deleted
 set fo+=n " Recognize lists. Not to be used with '2'
"set fo+=2 " Use the indent of the second line of a paragraph
"set fo+=v " Only break a line at blank entered during current insert
"set fo+=b " Like 'v', but only for blanks entered before wrap margin
 set fo+=l " Don't autoformat existing long lines
 set fo+=1 " Don't break a line after a one-letter word

" Delete comment character when joining commented lines
if v:version > 703 || v:version == 703 && has("patch541")
    set formatoptions+=j
endif

" Use the more intuitive + and - for incrementing and decrementing numbers
nnoremap + <C-a>
nnoremap - <C-x>

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

" Go to last location when using gf and <C-^>
noremap gf gf`"
noremap <C-^> <C-^>`"

set sessionoptions=blank,buffers,curdir,folds,help,options,winsize,tabpages

" Makes windows always equal size when resizing
set equalalways
function! AutoResize() " Made a function to enable easy toggling
    augroup Resize
        autocmd!
        autocmd WinEnter,VimResized * wincmd =
    augroup END
endfunction
call AutoResize()

" Sets minimum split width -- 80 + 6 for number + sign/fold columns
set winwidth=86

" Map annoying and useless <F1>, Q and K to more useful things
" <F1> does nothing, so it can be used for things outside of vim like changing
" windows in tmux
" Q repeats the macro in register q, as a more convenient way to macro
" K splits the line and removes trailing whitespace (reverse of J/gJ)
nnoremap <F1> <Nop>
nnoremap Q @q
set nojoinspaces
nnoremap K i<CR><Esc>k:call RemoveTrailingWS()<CR>$hl
function! RemoveTrailingWS()
    let g:_ishls = v:hlsearch
    let g:_lastsrch=@/
    s/\s\+$//e
    let @/=g:_lastsrch
    let v:hlsearch = g:_ishls
    unlet g:_lastsrch g:_ishls
endfunction

" Hitting { and } constantly gets painful, and ^ and $ are too useful to be so
" inconvenient. Not sure what to do with the default H and L though. I use
" keepjumps in normal mode so H and L don't write to the jumplist
noremap <silent> L }
noremap <silent> H {
nnoremap <silent> L :keepjumps normal! }<CR>
nnoremap <silent> H :keepjumps normal! {<CR>
noremap { ^
noremap } $

" Keep context when scrolling page by page
nnoremap <C-f> z+
nnoremap <C-b> z^
nnoremap <Leader>j z+
nnoremap <Leader>k z^

function! CenteringToggle()
    if &scrolloff!=99999
        let g:scrolloff_default_value = &scrolloff
        set scrolloff=99999
    else
        if exists(g:scrolloff_default_value)
            set scrolloff=g:scrolloff_default_value
            unlet g:scrolloff_default_value
        else
            set scrolloff=0
        endif
    endif
endfunction
nnoremap <silent> <Leader>z :<C-u>call CenteringToggle()<CR>

" Allow expected behavior when traversing wrapped lines
noremap j gj
noremap k gk
noremap gj j
noremap gk k

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

augroup CommandWindow
    autocmd!
    " have <Ctrl-C> leave cmdline-window
    autocmd CmdwinEnter * nnoremap <silent> <buffer> <C-c> :<C-u>q<CR>
    autocmd CmdwinEnter * inoremap <silent> <buffer> <C-c> <esc>:q<CR>
    " start command line window in insert mode and no line numbers
    autocmd CmdwinEnter * startinsert
    autocmd CmdwinEnter * set nonumber
    autocmd BufReadPost *
                \ if line("'\"") > 0 && line("'\"") <= line("$")
                \| exe "normal g'\"" | endif
augroup END
