" vimrc
" vim:set ft=vim tw=80 sw=4 et

" Clear autocmd settings -- stop autocommands from bogging down vim over time
if has("autocmd")
    autocmd!
endif

let g:mapleader = ","

" Plugins And Settings:
source ~/dotfiles/bundles.vim
source ~/dotfiles/plugins.vim
filetype plugin indent on

set backspace=indent,eol,start                      " Allow backspacing anywhere
set splitbelow splitright                 " Split windows below and to the right
set wildmenu wildmode=list:longest,full                 " Cmdline tab completion
set wildignore=*.o,*~,*.pyc,*.obj,*.a,*.lib,*.elf        " Ignore non-text files
set wildignore+=*.swp,*~,._* nobackup noswapfile               " Remove swapfile
set updatecount=0 nobackup nowritebackup         " Disable temp and backup files
set showcmd showmode cmdheight=1 shortmess=atIfilmnrxoOT    " Cmd bar appearance
set infercase complete-=i completeopt=longest,menuone        " Insert completion
set showmatch matchtime=1                                 " Parentheses matching
set nrformats=hex,alpha                     " Accepted bases for <C-a> and <C-x>
set hidden                                 " Allow modified buffers to be hidden
set incsearch hlsearch magic wrapscan                          " Search settings
set comments-=s1:/*,mb:*,ex:*/                        " /* Make C-style comments
set comments+=s:/*,mb:\ *,ex:\ */                     "  * wrap like this
set comments+=fb:*                                    "  */
set ignorecase smartcase " Search case matching: ignore case except if caps used
set ruler                        " Show comma-separated line and column location
set tabstop=8                     " Number of spaces that a tab char displays as
set softtabstop=4             " Number of spaces <Tab>/backspace inserts/removes
set shiftwidth=4                     " Number of spaces to increment >>, <<, etc
set expandtab                                          " Change <Tab>s to spaces
set smarttab        " Tab inserts shiftwidth spaces, backspace removes that many
set shiftround                       " Round indents to multiple of 'shiftwidth'
set shell=/bin/zsh                                               " Default shell
set mouse=a ttymouse=xterm2                                      " Mouse support
set nowrap linebreak textwidth=80 " Text wrapping: break line along spaces @~80c
set encoding=utf8 fileformats=unix,dos,mac          " Supported document formats
set foldmethod=marker foldnestmax=3 nofoldenable foldcolumn=0            " Folds
set diffopt=filler,vertical,foldcolumn:2                               " Vimdiff
set scrolloff=4 sidescrolloff=0                           " Scrolling boundaries
set number norelativenumber                                       " Line numbers
set autoread          " Reread a file detected to have been modified outside Vim
set autowrite                       " Automatically save file when focus is lost
set copyindent autoindent          " Imitate indenting of previous line's indent
set ttyfast notimeout ttimeout                         " See :help slow-terminal
syntax enable                                      " Turn on syntax highlighting
syntax sync minlines=256             " Update syntax highlighting for more lines
set synmaxcol=256                            " Don't syntax highlight long lines
set pastetoggle=<Leader>p                     " Toggle paste mode with <Leader>p
set switchbuf=useopen               " Switch to open buffer instead of reopening
set viewoptions=folds,options,cursor,unix,slash                     " Appearance
set laststatus=2                                    " Always display status line
set noerrorbells novisualbell                               " No annoying alerts
set viminfo='20,\"50,:10,/10,%,n~/.viminfo    " Remember things between sessions
set sessionoptions=blank,buffers,curdir,folds,help,options,winsize,tabpages
set winwidth=86   " Minimum split width -- 80 + 6 for number + sign/fold columns
set nojoinspaces          " Don't add extra spaces after .?! when joining with J
set equalalways         " Make current split be always at least "textwidth" wide

augroup Resize
    autocmd!
    autocmd WinEnter,VimResized * wincmd =       " Make splits always equal size
augroup END

" Settings for automatic text formatting
 set formatoptions=
 set fo+=t " Auto-wrap text using 'textwidth'
 set fo+=c " Auto-wrap comments + autoinsert comment leader
 set fo+=r " Insert current comment leader after hitting <CR>
"set fo+=o " Insert current comment leader after hitting 'o' or 'O'
 set fo+=q " Allow formatting with 'gq'
"set fo+=w " Trailing white space indicates a paragraph continues
"set fo+=a " Autoformat paragraphs every time text is inserted/deleted
 set fo+=n " Recognize lists. Not to be used with 'fo+=2'
"set fo+=2 " Use the indent of the second line of a paragraph
"set fo+=v " Only break a line at blank entered during current insert
"set fo+=b " Like 'v', but only for blanks entered before wrap margin
 set fo+=l " Don't autoformat existing long lines
 set fo+=1 " Don't break a line after a one-letter word

if v:version > 703 || v:version == 703 && has("patch541")
    set formatoptions+=j
endif

" Highlight last column so we know when we're over
if exists('+colorcolumn')
    if &textwidth != 0
        set colorcolumn=+0
    else
        set colorcolumn=80
    endif
elseif exists(':autocmd')
    highlight OverLength ctermbg=darkred ctermfg=white guibg=#FFD9D9
    augroup OverLengthCol
        autocmd!
        autocmd BufEnter *
                    \ exe 'match OverLength /\%>' .
                    \ &textwidth == 0 ? 80 : &textwidth .
                    \ 'v.\+/'
    augroup END
endif

" Remember undo history
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

"set list listchars=tab:▶\ ,trail:·

" Gvim-specific settings
" This really should go in its own .gvimrc
if has("gui_running")
    set guioptions=c
    if has("gui_gtk2")
        set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ Book\ 12
    elseif has("gui_macvim")
        set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ Book:12
    elseif has("gui_win32")
        set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ Book:12
    end
    set guitablabel=%M\ %t
    " Remove small delay between pressing Esc and entering Normal mode.
    set ttimeoutlen=10
    augroup FastEscape
        autocmd!
        au InsertEnter * set timeoutlen=0
        au InsertLeave * set timeoutlen=1000
    augroup END
endif

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

" Map annoying and useless <F1>, Q and K to more useful things
" <F1> does nothing, so it can be used for things outside of vim like changing
" windows in tmux
" Q repeats the macro in register q, as a more convenient way to macro
" K splits the line and removes trailing whitespace (reverse of J/gJ)
nnoremap <F1> <Nop>
nnoremap Q @q
nnoremap K :<C-u>call SplitHere()<CR>
function! SplitHere()
    execute "normal! i\<CR>\<Esc>k$hl"
    if getline(line('.'))[col('.')-1] =~ '\s'
        execute 'normal! "_diw'
    endif
endfunction

" Open help in a vertical split instead of the default horizontal split
" " http://vim.wikia.com/wiki/Replace_a_builtin_command_using_cabbrev
cabbrev h <C-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'vert h' : 'h')<CR>
cabbrev help <C-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'vert h' : 'help')<CR>

" Use ,q to quit nameless buffers without confirmation or !
nnoremap <silent> <Leader>q :<C-u>call QuitIfNameless()<CR>:q<CR>
function! QuitIfNameless()
    if empty(bufname('%'))
        setlocal nomodified
    endif
endfunction

" Replace 'ddate' with current date, 'ttime' with current time
if exists("*strftime")
    iabbrev ddate <C-r>=strftime("%m/%d/%Y")<CR>
    iabbrev ttime <C-r>=strftime("%Y-%m-%d %a %H:%M")<CR>
endif

" Use 'verymagic' search. Does not apply to substitutions; if you want to
" verymagic your substitutions, use the last search register or add \v manually
nnoremap / /\v

" Add a relative number toggle
nnoremap <Leader>r :<C-u>set rnu!<CR>

" Newline without automatically adding leading characters (e.g. comment chars)
inoremap <C-j> <CR><C-u>

" Allow redo for insert mode ^u
inoremap <C-u> <C-g>u<C-u>

" Since the ',' command is actually useful, set it to ',,'
nnoremap <Leader>, ,
nnoremap <silent> <Leader>/ :<C-u>nohlsearch<CR>
nnoremap <silent> <Leader>w :<C-u>update!<CR>
if isdirectory(expand('~/dotfiles'))
    nnoremap <silent> <Leader>ev :<C-u>vsplit ~/dotfiles/vimrc<CR>
    nnoremap <silent> <Leader>eb :<C-u>vsplit ~/dotfiles/bundles.vim<CR>
    nnoremap <silent> <Leader>ep :<C-u>vsplit ~/dotfiles/plugins.vim<CR>
    nnoremap <silent> <Leader>ez :<C-u>vsplit ~/dotfiles/zshrc<CR>
    nnoremap <silent> <Leader>ez :<C-u>vsplit ~/dotfiles/custom/aliases.zsh<CR>
else
    nnoremap <silent> <Leader>ev :<C-u>vsplit ~/.vimrc<CR>
    nnoremap <silent> <Leader>ez :<C-u>vsplit ~/.zshrc<CR>
endif
nnoremap <silent> <Leader>el :<C-u>vsplit ~/.localrc.zsh<CR>
nnoremap <silent> <Leader>sv :<C-u>so $MYVIMRC<CR>
nnoremap <silent> <Leader>sl yy:execute @@<CR>
xnoremap <silent> <Leader>sl y:execute @@<CR>gv<esc>

nnoremap <silent> m :<C-u>update!<CR>:<C-u>call MakeIfPossible()<CR>
function! MakeIfPossible()
    if &makeprg != 'make' || filereadable(expand('%:p:h') . "/Makefile")
        make
    endif
endfunction

" Open a Quickfix window for the last search.
nnoremap <silent> <Leader>? :execute 'vimgrep /'.@/.'/g %'<CR>:copen<CR>

" Delete to black hole register
nnoremap <silent> <Leader>d "_d

" Switch buffers with a count: 3! with switch to buffer 3
" Delete buffers the same way with ~
nnoremap <expr> ! v:count ? ":<C-u>b<C-r>=v:count<CR><CR>" : "!"
nnoremap <expr> ~ v:count ? ":<C-u>bd!<C-r>=v:count<CR><CR>" : "~"

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
        au FileType html       setlocal ts=8 sts=4 sw=4 et
        au FileType css        setlocal ts=8 sts=4 sw=4 et
        au FileType javascript setlocal ts=4 sts=4 sw=4 noet
        au FileType c          setlocal ts=4 sts=4 sw=4 et
        au FileType vim        setlocal ts=4 sts=4 sw=4 et
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

" Use the more intuitive + and - for incrementing and decrementing numbers
nnoremap + <C-a>
nnoremap - <C-x>

" Set Y to match C and D syntax (use yy to yank entire line)
nnoremap Y y$

" Go to last location when using gf and <C-^>
noremap gf gf`"
noremap <C-^> <C-^>`"

" Hitting { and } constantly gets painful, and ^ and $ are too useful to be so
" inconvenient. Not sure what to do with the default H and L though. I use
" keepjumps in normal mode so H and L don't write to the jumplist
noremap <silent> L }
noremap <silent> H {
nnoremap <silent> L :<C-u>execute 'keepjumps normal!' v:count1 . '}'<CR>
nnoremap <silent> H :<C-u>execute 'keepjumps normal!' v:count1 . '{'<CR>
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
        if exists('g:scrolloff_default_value')
            let &scrolloff=g:scrolloff_default_value
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
                \| execute "normal g'\"" | endif
augroup END
