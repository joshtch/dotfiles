" vimrc
" vim:set ft=vim tw=80 sw=4 et

nnoremap <Space> <Nop>
let g:mapleader = " "

" Plugins And Settings:
if filereadable(expand('~/dotfiles/plugs.vim')) &&
            \ filereadable(expand('~/dotfiles/plugins.vim'))
    source ~/dotfiles/plugs.vim
    source ~/dotfiles/plugins.vim
endif
filetype plugin indent on

set backspace=indent,eol,start
set splitbelow splitright
set wildmenu wildmode=list:longest,full
set wildignore=*.o,*~,*.pyc,*.obj,*.a,*.lib,*.elf,.git*,*.swp,*~,._*,*.bak
set backup noswapfile updatecount=0 autowrite
set showcmd showmode cmdheight=1 shortmess=atIfilmnrxoOT
set laststatus=2 ruler
set noshowmode         " Don't show -- INSERT -- or whatever in the command line
set infercase complete-=i completeopt=longest,menuone
set showmatch matchtime=1
set nrformats=hex,alpha
set hidden
set incsearch hlsearch magic wrapscan ignorecase smartcase
set tabstop=8 softtabstop=4 expandtab smarttab
set shiftwidth=4 shiftround copyindent autoindent
set shell=/bin/sh
set t_ut=                                                    " Fix tmux coloring
set mouse=a ttymouse=xterm2
set nowrap linebreak textwidth=80
set encoding=utf8 fileformats=unix,dos,mac
set foldmethod=manual foldnestmax=3 nofoldenable foldcolumn=0
set diffopt=filler,vertical,iwhite,hiddenoff
set scrolloff=4 sidescrolloff=1
set number norelativenumber
set ttyfast                                            " See :help slow-terminal
set switchbuf=useopen,vsplit
set viewoptions=folds,options,cursor,unix,slash
set noerrorbells novisualbell
set viminfo='20,\"50,:10,/10,%,n~/.viminfo
set sessionoptions=blank,buffers,curdir,folds,help,options,winsize,tabpages
set winwidth=86                          " 80 + 6 for number + sign/fold columns
set nojoinspaces                  " Don't add extra space after .?! when using J
set equalalways         " Make current split be always at least "textwidth" wide
set cryptmethod=blowfish
set path=.,**
if exists('+breakindent') | set breakindent | endif

" Syntax Highlighting:
syntax enable
syntax sync minlines=512
set synmaxcol=512
" Default paren match highting is too distracting
highlight! link MatchParen Comment
" Remove underlining from closed folds
highlight Folded term=bold cterm=bold
" Hide comments
function! HideCommentsByFolding()
    setlocal foldtext=repeat('\ ',9999)
    setlocal foldminlines=0
    setlocal foldmethod=expr
    setlocal foldexpr=getline(v:lnum)=~'^\\s*\\(//\\\|$\\)'
    setlocal foldlevel=0 foldenable
    highlight Folded cterm=bold term=bold gui=bold ctermbg=NONE guibg=NONE
endfunction

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\||\)\{7\}\([^=].\+\)\?$'

set autoread          " Reread a file detected to have been modified outside Vim
augroup AutoReading
    autocmd!
    autocmd CursorHold,CursorHoldI * if getcmdpos() == 0 | checktime | endif
augroup END

augroup Resize                    " Make splits equal size, unless in focus mode
    autocmd!
    autocmd WinEnter,VimResized * if &l:ft != 'focusmode' | wincmd = | endif
augroup END

" Settings for automatic text formatting (Vim default: tcq)
 set formatoptions=
 set fo+=t " Auto-wrap text using 'textwidth'
 set fo+=c " Auto-wrap comments + autoinsert comment leader
 set fo+=r " Insert current comment leader after hitting <CR>
"set fo+=o " Insert current comment leader after hitting 'o' or 'O'
 set fo+=q " Allow formatting with 'gq'
"set fo+=w " Trailing white space indicates a paragraph continues
"set fo+=a " Autoformat paragraphs every time text is inserted/deleted
"set fo+=n " Recognize lists. Not to be used with 'fo+=2'
 set fo+=2 " Use the indent of the second line of a paragraph
"set fo+=v " Only break a line at blank entered during current insert
"set fo+=b " Like 'v', but only for blanks entered before wrap margin
"set fo+=l " Don't autoformat existing long lines
 set fo+=1 " Don't break a line after a one-letter word
if v:version > 703 || v:version == 703 && has("patch541")
    set formatoptions+=j " Where it makes sense, remove comment leader when joining lines
endif

" Settings for Vi-compatible behavior (Vim default: aABceFs)
" Note: this list is not exhaustive. See :h 'cpo'
 set cpoptions=
"set cpo+=a " :read command with a file name will modify the window's alternate file name
"set cpo+=A " :write command with a file name will modify the window's alternate file name
 set cpo+=B " Give backslash no special meaning in mappings, abbreviations and the 'to' part of the menu commands
 set cpo+=c " Searching continues at the end of any match at the cursor position, but not further than the start of the next line
 set cpo+=e " When executing a register with ':@r', always add a <CR> to the last line even when the register is not linewise
 set cpo+=F " :write with a file name argument will set the file name for the current buffer if it doesn't have one already
"set cpo+=i " Interrupting the reading of a file will leave it modified.
 set cpo+=K " Don't wait for a key code to complete
"set cpo+=m " 'Showmatch' will always wait half a second, even if a character is typed within that time period
 set cpo+=q " Joining multiple lines leaves the cursor where it would be when joining two lines
"set cpo+=s " Set buffer options when first entering the buffer instead of when it's created
"set cpo+=t " Search pattern for the tag command is remembered for 'n' command
 set cpo+={ " The { and } commands also stop at a '{' character at the start of a line.

" Highlight last column so we know when we're over
if exists('+colorcolumn')
    if &textwidth != 0
        set colorcolumn=+1
    else
        set colorcolumn=81
    endif
elseif has("autocmd") " Highlight text that's over our limit
    highlight link OverLength Cursor
    augroup OverLengthCol
        autocmd!
        autocmd BufEnter,BufWrite *
                    \ execute 'match OverLength /\%>'
                    \ . (&textwidth == 0 ? 80 : &textwidth)
                    \ . 'v.\+/'
    augroup END
endif
exe 'nnoremap <silent> <Leader>n /\%>' . (&textwidth ? (&textwidth + 1) : 81)
            \ . 'v.\+<cr>'
exe 'nnoremap <silent> <Leader>N ?\%>' . (&textwidth ? (&textwidth + 1) : 81)
            \ . 'v.\+<cr>'

set undodir=~/.vim/tmp/undo//     " undo files
set backupdir=~/.vim/tmp/backup// " backups
set directory=~/.vim/tmp/swap//   " swap files

" Make those folders automatically if they don't already exist.
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), "p")
endif

" Remember undo history
if exists("+undofile")
    set undodir=./.vim-undo//
    set undodir+=~/.vim/tmp/undo//
    set undofile
    set undolevels=1000  " How many undos to save
    set undoreload=10000 " Number of lines to save per undo
endif

" Remember cursor position
function! ResCur()
    if line("'\"") <= line("$")
        silent! normal! g`"
    endif
endfunction
augroup resCur
    autocmd!
    autocmd BufWinEnter * call ResCur()
augroup END

"set list listchars=tab:▶\ ,trail:·

" Gvim-specific settings
" This really should go in its own .gvimrc
if has('gui_running')
    set guioptions=c " Least obtrusive gui possible
    set guicursor=a:blinkon0,i:ver1
    set guifont=PowerlineSymbols
else "Terminal
    " Remove small delay between pressing Esc and entering Normal mode.
    set timeout ttimeout ttimeoutlen=-1
    augroup FastEscape
        autocmd!
        au InsertEnter * set timeoutlen=0
        au InsertLeave * set timeoutlen=1000
    augroup END
endif

" Highlight screen line of the cursor, but only in current window
augroup CursorLine
    autocmd!
    autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    autocmd WinLeave * setlocal nocursorline
augroup END

" Always show line numbers, but only in current window.
augroup ShowLineNumber
    autocmd!
    autocmd WinEnter * setlocal number
    autocmd WinLeave * setlocal nonumber
augroup END

" Map annoying and useless <F1>, Q, and K to more useful things
" - <F1> unmapped so it can be used outside of vim for changing tmux windows
" - Q repeats the last macro used, making using macros more convenient
" - K splits the line and removes trailing whitespace (reverse of J/gJ)
nnoremap <F1> <Nop>
nnoremap Q @@
nnoremap <silent> <Plug>Split :<C-U>call <SID>Split()<Bar>silent! call repeat#set("\<lt>Plug>Split",-1)<CR>
nmap K <Plug>Split
function! s:Split()
    execute "normal! i\<CR>\<Esc>k$hl"
    if getline(line('.'))[col('.')-1] =~ '\s'
        execute 'normal! "_diw'
    endif
endfunction

" Fly through buffers
nnoremap <Leader>b :<C-U>ls<cr>:<C-U>b<Space>

" Always go down with n & up with N -- this avoids confusion if you resume
" a search later
nnoremap n /<C-U><CR>
nnoremap N ?<C-U><CR>

" Evaluate floating point math in place - ("math after" and "math replace")
nnoremap <Leader>ma yyp^y$V:!perl -e '$x = <C-R>"; print $x'<CR>-y0j0P
vnoremap <Leader>ma yo<Esc>p^y$V:!perl -e '$x = <C-R>"; print $x'<CR>-y0j0P
nnoremap <Leader>mr ^"gy0^y$V:!perl -e '$x = <C-R>"; print $x'<CR>^"gP
vnoremap <Leader>mr "aygvrXgv"by:r !perl -e '$x = <C-R>a; print $x'<CR>0"cyWddk:s/<C-R>b/<C-R>c/<CR>

" Open help in a vertical split instead of the default horizontal split
" " http://vim.wikia.com/wiki/Replace_a_builtin_command_using_cabbrev
cabbrev h <C-R>=(getcmdtype()==':' && getcmdpos()==1 ? 'vert h' : 'h')<CR>
cabbrev help <C-R>=(getcmdtype()==':' && getcmdpos()==1 ? 'vert h' : 'help')<CR>

" Use :w!! to save a file with super-user permissions
cabbrev w!! <C-R>=(getcmdtype()==':' && getcmdpos()==1 ? 'w !sudo tee % >/dev/null' : 'w!!')<CR>

" Use <leader>q to quit nameless buffers without confirmation or !
nnoremap <silent> <Leader>q :<C-U>call QuitIfNameless()<CR>
function! QuitIfNameless()
    if empty(bufname('%'))
        setlocal nomodified
    endif
    execute 'confirm quit'
endfunction

" Replace 'ddate' with current date, 'ttime' with current time
if exists("*strftime")
    iabbrev ddate <C-R>=strftime("%m/%d/%Y")<CR>
    iabbrev ttime <C-R>=strftime("%Y-%m-%d %a %H:%M")<CR>
endif

" PRNG from 'od'
if executable('od')
    iabbrev rand1  <C-R>=system('od -vAn -N1 -td1 < /dev/urandom \| tr -d "\n\r \t"')<CR><C-R>=<cr>
    iabbrev rand2  <C-R>=system('od -vAn -N2 -td2 < /dev/urandom \| tr -d "\n\r \t"')<CR>
    iabbrev rand4  <C-R>=system('od -vAn -N4 -td4 < /dev/urandom \| tr -d "\n\r \t"')<CR>
    iabbrev rand8  <C-R>=system('od -vAn -N8 -td8 < /dev/urandom \| tr -d "\n\r \t"')<CR>
    iabbrev urand1 <C-R>=system('od -vAn -N1 -tu1 < /dev/urandom \| tr -d "\n\r \t"')<CR>
    iabbrev urand2 <C-R>=system('od -vAn -N2 -tu2 < /dev/urandom \| tr -d "\n\r \t"')<CR>
    iabbrev urand3 <C-R>=system('od -vAn -N3 -tu3 < /dev/urandom \| tr -d "\n\r \t"')<CR>
    iabbrev urand4 <C-R>=system('od -vAn -N4 -tu4 < /dev/urandom \| tr -d "\n\r \t"')<CR>
endif

" Use 'verymagic' search. Does not apply to substitutions; if you want to
" verymagic your substitutions, use the last search register or add \v manually
nnoremap / /\v
nnoremap ? ?\v

" Relative number toggle
nnoremap <silent> <Leader>r :<C-U>set relativenumber!<CR>

" Newline without leading characters (e.g. comment chars)
inoremap <C-J> <CR><C-U>

" Allow redo for insert mode ^u
inoremap <C-U> <C-G>u<C-U>

nnoremap <silent> <Leader>/ :<C-U>nohlsearch<CR>
nnoremap <silent> <Leader>w :<C-U>update!<CR>
if isdirectory(expand('~/dotfiles'))
    nnoremap <silent> <Leader>ev :<C-U>vsplit ~/dotfiles/vimrc<CR>
    nnoremap <silent> <Leader>en :<C-U>vsplit ~/dotfiles/bundles.vim<CR>
    nnoremap <silent> <Leader>eb :<C-U>vsplit ~/dotfiles/plugs.vim<CR>
    nnoremap <silent> <Leader>ep :<C-U>vsplit ~/dotfiles/plugins.vim<CR>
    nnoremap <silent> <Leader>ez :<C-U>vsplit ~/dotfiles/zshrc<CR>
    nnoremap <silent> <Leader>ea :<C-U>vsplit ~/dotfiles/aliases.zsh<CR>
else
    nnoremap <silent> <Leader>ev :<C-U>vsplit ~/.vimrc<CR>
    nnoremap <silent> <Leader>ez :<C-U>vsplit ~/.zshrc<CR>
endif
nnoremap <silent> <Leader>el :<C-U>vsplit ~/.localrc.zsh<CR>
nnoremap <silent> <Leader>sv :<C-U>so $MYVIMRC<CR>
nnoremap <silent> <Leader>sll yy:execute @@<CR>
xnoremap <silent> <Leader>sl y:execute @@<CR>gv<esc>
function! SourceThis(...)
    let a_reg = @a
    norm! `["ay`]
    echo ''
    exe @a
    let @a = a_reg
endfunction
nnoremap <silent> <Leader>sl :set opfunc=SourceThis<CR>g@

nnoremap <silent> m :<C-U>update!<CR>

" Open a Quickfix window for the last search.
nnoremap <silent> <Leader>? :execute 'vimgrep /'.@/.'/g %'<CR>:copen<CR>

" Delete to black hole register
nnoremap <silent> <Leader>d "_d

" Switch buffers with a count: 3! will switch to buffer 3
" Delete buffers the same way with ~
nnoremap <expr> ! v:count ? ":<C-U>b<C-R>=v:count<CR><CR>" : "!"
nnoremap <expr> ~ v:count ? ":<C-U>bd!<C-R>=v:count<CR><CR>" : "~"

if has("autocmd")
    filetype on

    augroup filetype_commands
        autocmd!
        " Syntax of these languages is fussy over tabs Vs spaces
        au FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
        au FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

        au FileType html,css setlocal ts=8
                    \ omnifunc=htmlcomplete#CompleteTags
                    \| iabbrev </ </<C-x><C-o>
        au FileType sml setlocal makeprg="mosmlc %"
        au FileType c,cpp,javascript,slang setlocal cindent fo+=r
                    \ com-=s1:/*,mb:*,ex:*/ com+=s:/*,mb:\ *,ex:\ */,fb:*
        au FileType javascript,html,xhtml,css,php setlocal sw=2 ts=2 fdm=indent
        "au BufWrite *.js,*.html,*.css,*.php exec "silent! !open '" . expand('%') ."'"
        au FileType crontab setlocal backupcopy=yes
        au BufEnter *.md setlocal filetype=markdown

        " Fix syntax highlighting of vim helpfiles, since 'modeline' is off
        au BufEnter *.txt
            \ if expand('%:p:h') =~? '.*/\.\?vim/.*/(doc|macros)'
            \| setfiletype help | endif

        " Treat ImpCore as Scheme (Comp105)
        au BufNewFile,BufRead *.imp,*.ic setfiletype scheme

        " Treat .rss files as XML
        autocmd BufNewFile,BufRead *.rss setfiletype xml

        autocmd FileType python setlocal ts=4 sts=4 sw=4 et
        autocmd FileType ruby   setlocal ts=2 sts=2 sw=2 et
        autocmd FileType vhdl   setlocal commentstring=--%s
                    \ makeprg=vlib\ work\;\ vcom\ %
                    \ errorformat=**\ Error:\ %f(%l):\ %m
    augroup END
endif

" Use the more intuitive + and - for incrementing and decrementing numbers
noremap + <C-A>
noremap - <C-X>

" Set Y to match C and D syntax (use yy to yank entire line)
nnoremap Y Dp

" Go to last location when using gf and <C-^>
noremap gf gf`"
noremap <C-^> <C-^>`"

" Hitting { and } constantly gets painful, and ^ and $ are too useful to be so
" inconvenient. The normal H and L have been offloaded to gH and gL. I use
" keepjumps in normal mode so H and L don't write to the jumplist, and add V to
" operator-pending mode so the motion acts linewise instead of characterwise
xnoremap L }
xnoremap H {
xnoremap gL L
xnoremap gH H
onoremap L V}
onoremap H V{
onoremap gL L
onoremap gH H
nnoremap <silent> L :<C-U>execute 'keepjumps normal!' v:count1 . '}'<CR>
nnoremap <silent> H :<C-U>execute 'keepjumps normal!' v:count1 . '{'<CR>
noremap { ^
noremap } $

" Type 'cd' to change vim's working directory to that of the current buffer
nnoremap cd :cd %:h<CR>

nnoremap <silent> <Leader><Leader> :let &scrolloff=999-&scrolloff<CR>
augroup CenteringReadOnly
    autocmd!
    autocmd BufEnter * if !&modifiable | setlocal scrolloff=999 | endif
augroup END

" Auto fold lines matching last search pattern
" Only works with marker & manual folding
nnoremap <silent> zF :setlocal foldexpr=(getline(v:lnum)=~@/)?0:(getline(v:lnum-1)=~@/)\\|\\|(getline(v:lnum+1)=~@/)?0:1 foldmethod=expr foldlevel=0 foldcolumn=1<CR>
set foldopen-=search " Disable opening folds when a search match is found inside
set foldopen-=block  " Disable opening folds when moving to block markers

" Allow expected behavior when traversing wrapped lines
noremap  j  gj
onoremap j  Vgj
noremap  k  gk
onoremap k  Vgk
noremap  gj j
noremap  gk k

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
    autocmd CmdwinEnter * nnoremap <silent> <buffer> <C-C> :<C-U>q<CR>
    autocmd CmdwinEnter * inoremap <silent> <buffer> <C-C> <esc>:q<CR>
    " start command line window in insert mode and no line numbers
    autocmd CmdwinEnter * startinsert
    autocmd CmdwinEnter * set nonumber
    autocmd BufReadPost *
                \ if line("'\"") > 0 && line("'\"") <= line("$")
                \| execute "normal g'\"" | endif
augroup END

" The following saves and loads buffers' foldview settings between sessions {{{
" All this code originates from https://github.com/vim-scripts/restore_view.vim
" which itself originates from the vim wiki http://vim.wikia.com/wiki/VimTip991
if !exists("g:skipview_files")
    let g:skipview_files = []
endif
function! MakeViewCheck()
    if has('quickfix') && &buftype =~ 'nofile' | return 0 | endif
    if expand('%') =~ '\[.*\]' | return 0 | endif
    if empty(glob(expand('%:p'))) | return 0 | endif
    if &modifiable == 0 | return 0 | endif
    if len($TEMP) && expand('%:p:h') == $TEMP | return 0 | endif
    if len($TMP) && expand('%:p:h') == $TMP | return 0 | endif
    let file_name = expand('%:p')
    for ifiles in g:skipview_files
        if file_name =~ ifiles
            return 0
        endif
    endfor
    return 1
endfunction
augroup AutoView
    autocmd!
" Autosave & Load Views.
    autocmd BufWritePost,WinLeave,BufWinLeave ?* if MakeViewCheck() | mkview | endif
    autocmd BufWinEnter ?* if MakeViewCheck() | silent! loadview | endif
augroup END
"}}}

" Trailing Whitespace: {{{
function! DisableWhitespace()
    silent! autocmd! AnnoyingWhitespace
    silent! syn clear EOLWS
    call clearmatches()
endfunction

function! EnableWhitespace()
    silent! call DisableWhitespace()
    highlight default link ExtraWhitespace ErrorMsg
    highlight default link EOLWS ErrorMsg
    match ExtraWhitespace /\s\+$/
    augroup AnnoyingWhitespace
        autocmd!
        autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
        autocmd InsertEnter * match ExtraWhitespace /\v\s+%#@<!$/
        autocmd InsertLeave * match ExtraWhitespace /\s\+$/
        autocmd BufWinLeave * call clearmatches()
        autocmd InsertEnter *
                    \ syn clear EOLWS | syn match EOLWS excludenl /\v\s+%#@!$/
        autocmd InsertLeave *
                    \ syn clear EOLWS | syn match EOLWS excludenl /\s\+$/
    augroup END
endfunction

call EnableWhitespace()

function! StripTrailingWhitespace()
    silent! let ishls=v:hlsearch
    let lastsearch=@/
    let pos=getpos('.')
    %s/\s\+$//e
    let @/=lastsearch
    silent! let v:hlsearch=ishls
    call setpos('.',pos)
endfunction

augroup ClearTrailingWSOnSave
    autocmd!
    autocmd BufWritePre *.py,*.js call StripTrailingWhitespace()
    autocmd BufLeave * call DisableWhitespace()
    autocmd BufEnter * if !(&ft=='unite' || &ft=='markdown')
                \| call EnableWhitespace() | endif
augroup END
nnoremap <silent> <Leader>cws :<C-U>call StripTrailingWhitespace()<CR>
" }}}

" DoWordMotion: Fix Vim's crazy cw & cW maps {{{
" Based on github.com/ap/vim-you-keep-using-that-word
function! DoWordMotion(motion)
    if a:motion =~# '[wW]'
        let before = line('.')
        execute 'normal! v'.v:count1.a:motion.'h'
        if line('.') != before
            let target = winsaveview()
            let before = line('.')
            exe 'normal!' (a:motion == 'w' ? 'ge' : 'gE')
            if line('.') == before
                call winrestview(target)
            endif
        endif
    else
        echoerr "motion not recognized"
    endif
endfunction
onoremap <silent> w :<C-U>silent! call DoWordMotion('w')<CR>
onoremap <silent> W :<C-U>silent! call DoWordMotion('W')<CR>
" }}}

" Hex Mode Toggling: {{{
" The following maps the F8 key to toggle between hex and binary (while also
" setting the noeol and binary flags, so if you :write your file, vim doesn't
" perform unwanted conversions.

noremap <F8> :call HexMe()<CR>

let $in_hex=0
function! HexMe()
    set binary
    set noeol
    if $in_hex>0
        :%!xxd -r
        let $in_hex=0
    else
        :%!xxd
        let $in_hex=1
    endif
endfunction
" }}}
