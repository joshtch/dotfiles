" vimrc
" vim:set ft=vim tw=95 sw=4 et fen fdm=marker fmr=\ {{{,\ }}} :

" Set leader character {{{
" This should be set before loading plugins because some plugins incorrectly
" hard-code leader bindings.
nnoremap <Space> <Nop>
let g:mapleader = ' '

" }}}
" Plugins And Settings: {{{
if filereadable(expand('~/dotfiles/plugs.vim')) &&
            \ filereadable(expand('~/dotfiles/plugins.vim'))
    source ~/dotfiles/plugs.vim
    source ~/dotfiles/plugins.vim
endif
filetype plugin indent on

" }}}
" Options {{{
" Vim Options: {{{
set backspace=indent,eol,start                      " Allow backspacing anywhere
set splitbelow splitright                 " Split windows below and to the right
set wildmenu wildmode=list:longest,full                 " Cmdline tab completion
set wildignore+=*.o,*.pyc,*.obj,*.a,*.lib,*.elf,.git*    " Ignore non-text files
set wildignore+=*.swp,*~,._*,*.bak                " Ignore backups and swapfiles
set autowrite backup writebackup                                 " Keep backups
set noswapfile updatecount=0                             " Do not use swapfiles
set showcmd showmode cmdheight=1 shortmess=atIfilmnrxoOT    " Cmd bar appearance
set infercase complete-=i completeopt=longest,menuone        " Insert completion
set showmatch matchtime=1                                 " Parentheses matching
set nrformats=hex,alpha                     " Accepted bases for <C-A> and <C-X>
set hidden                                 " Allow modified buffers to be hidden
set incsearch hlsearch magic wrapscan                          " Search settings
set ignorecase smartcase " Search case matching: ignore case except if caps used
set ruler                        " Show comma-separated line and column location
set tabstop=4                     " Number of spaces that a tab char displays as
set softtabstop=4             " Number of spaces <Tab>/backspace inserts/removes
set shiftwidth=4                     " Number of spaces to increment >>, <<, etc
set expandtab                                          " Change <Tab>s to spaces
set smarttab        " Tab inserts shiftwidth spaces, backspace removes that many
set shiftround                       " Round indents to multiple of 'shiftwidth'
set t_ut=                    " Clear using background color -- fix tmux coloring
set mouse=a ttymouse=xterm2                                      " Mouse support
set nowrap linebreak textwidth=95 " Text wrapping: break line along spaces @~95c
set encoding=utf-8 fileformats=unix,dos,mac         " Supported document formats
set diffopt=filler,vertical,foldcolumn:2,iwhite                        " Vimdiff
set scrolloff=4 sidescrolloff=0                           " Scrolling boundaries
set number norelativenumber                                       " Line numbers
set autowrite                       " Automatically save file when focus is lost
set copyindent autoindent          " Imitate indenting of previous line's indent
set ttyfast                                            " See :help slow-terminal
set switchbuf=useopen           " Switching buffers, use open window if possible
set viewoptions=cursor,folds,slash,unix " Buffer options to remember with mkview
set laststatus=2                                    " Always display status line
set noshowmode         " Don't show -- INSERT -- or whatever in the command line
set noerrorbells novisualbell                               " No annoying alerts
set viminfo='20,\"50,:10,/10,%,n~/.viminfo    " Remember things between sessions
set sessionoptions=blank,buffers,curdir,help,options,winsize,tabpages
set winwidth=101  " Minimum split width -- 95 + 6 for number + sign/fold columns
set nojoinspaces          " Don't add extra spaces after .?! when joining with J
set equalalways         " Make current split be always at least "textwidth" wide
set cryptmethod=blowfish               " Use slightly less insecure cryptography
set path=.,**        " Make :find, :sfind, :vert sfind search parent directories
set virtualedit=block                   " Let cursor move anywhere in block mode
set listchars=eol:↩,tab:⇥\ ,trail:·,extends:⇨,precedes:⇦,conceal:●,nbsp:⸰ nolist
silent! set breakindent                                   " Indent wrapped lines
set display+=lastline                " Show markings to indicate the end of file
silent! setglobal tags-=./tags tags-=./tags; tags^=./tags;
set history=1000 tabpagemax=50
set viminfo^=!
set sessionoptions-=options
set display^=uhex              " Show unprintable characters hexadecimal as <xx>
silent! set emoji     " Show emoji characters as full width, multibyte character
set nofixeol                             " Do not insert an <EOL> if none exists
set noexrc secure    " Do not load .vimrc, .exrc or .gvimrc in current directory

" }}}
" Folding {{{
set foldmethod=manual foldnestmax=3 nofoldenable foldcolumn=0
set foldmarker=\ {{{,\ }}}
set foldtext=MyFoldText()

function! MyFoldText() abort
    " Foldtext format:
    " "-- |Some file text| ----------------------------------- 123 lines - ({{2"
    " "-- |Another example showing truncation of long tex...| - 10 lines - ({{2"
    let line = getline(v:foldstart)
    let fillchar = substitute(&fillchars, '.*fold:\ze.\|fold:.\zs.*', '', 'g')
    if fillchar !~? '.'
        let fillchar = '~'
    endif

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 1
    let foldedlinecount = v:foldend - v:foldstart

    let foldopenmarker = substitute(&foldmarker, ',.*', '', '')
    let line = substitute(line, foldopenmarker.'\d\=.*', '', '')

    " Expand tabs into spaces
    let onetab = strpart('        ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let head = v:folddashes
    let tail = foldedlinecount . ' lines '.fillchar.' {{'.'{' . v:foldlevel 
    let maxtextlen = windowwidth - strlen(head . ' |' . '| ~ ' . tail)
    if strlen(line) > maxtextlen
        let line = strpart(line, 0, maxtextlen - 3) . '...'
    endif
    let fillcharcount = windowwidth - strlen(head.' |'.line.'| '.' '.tail)
    let filler = repeat(fillchar, fillcharcount)
    return head . ' |' . line . '| ' . filler . ' ' . tail . ' '
endfunction

" }}}
" OS Identifier: use g:os variable to get the OS version {{{
if has("win64") || has("win32") || has("win16")
    let g:os = "Windows"
else
    let g:os = substitute(system('uname'), '\n', '', '')
endif

" }}}
" OS Specific Options: {{{
if g:os == "Windows"
    lang C
    set viminfo='20,\"512,nc:/tmp/_viminfo
    set iskeyword=48-57,65-90,97-122,_,161,163,166,172,177,179,182,188,191,198,202,209,211,230,234,241,243,143,156,159,165,175,185
else
    set shell=/bin/bash " Set default background shell
endif

" }}}
" Syntax Highlighting: {{{
syntax enable                                      " Turn on syntax highlighting
syntax sync minlines=512             " Update syntax highlighting for more lines
set synmaxcol=512                            " Don't syntax highlight long lines
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

" }}}
" Reread a file detected to have been modified outside Vim {{{
set autoread          " Reread a file detected to have been modified outside Vim
augroup AutoReading
    autocmd!
    autocmd CursorHold,CursorHoldI * checktime
augroup END

" }}}
" Make splits equal size, unless in focus mode (see focus.vim plugin) {{{
augroup Resize                    " Make splits equal size, unless in focus mode
    autocmd!
    autocmd WinEnter,VimResized * if &l:ft != 'focusmode' | wincmd = | endif
augroup END

" }}}
" Formatoptions: Settings for automatic text formatting (Vim default: tcq) {{{
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
if v:version > 703 || v:version == 703 && has('patch541')
    set formatoptions+=j " Where it makes sense, remove comment leader when joining lines
endif

" }}}
" Cpoptions: Settings for Vi-compatible behavior (Vim default: aABceFs) {{{
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

" }}}
" Highlight last column so we know when we're over {{{
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
                    \ . (&textwidth == 0 ? 95 : &textwidth)
                    \ . 'v.\+/'
    augroup END
endif

" }}}
" Set up undo, backup, and undo file directories {{{
" Use this command in Zsh once in a while to clear out unnecessary undo files:
" undodir="$HOME/.vim/tmp/undo" && find "$undodir" -mindepth 1 -type f | \
"    cut -c $(( ${#undodir}+2 ))- | \
"    ( while read -r file; do test -f "${file//\%//}" || rm "${undodir}/${file}"; done )
set backupdir=~/.vim/tmp/backup// " backups
set directory=~/.vim/tmp/swap//   " swap files

" Make those folders automatically if they don't already exist.
if has('persistent_undo')
    set undodir=~/.vim/tmp/undo//     " undo files
    if !isdirectory(expand(&undodir))
        call mkdir(expand(&undodir), "p")
    endif
endif
if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), "p")
endif

" Do the same for views, but only if Vim was compiled with the feature
if has('mksession')
    set viewdir=~/.vim/tmp/view//
    if !isdirectory(expand(&viewdir))
        call mkdir(expand(&viewdir), 'p')
    endif
endif

" }}}
" Remember undo history {{{
if exists('+undofile')
    set undodir=./.vim-undo//
    set undodir+=~/.vim/tmp/undo//
    set undofile
    set undolevels=1024  " How many undos to save
    set undoreload=65536 " Number of lines to save per undo
endif

" }}}
" Gvim-specific settings {{{
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
        autocmd InsertEnter * set timeoutlen=0
        autocmd InsertLeave * set timeoutlen=1000
    augroup END
endif

" }}}
" Highlight cursor screen line and show line numbers in current window {{{
" Turned off if buffer is not modifiable (e.g. help page)
augroup CursorLine
    autocmd!
    autocmd WinEnter * if &modifiable | setlocal cursorline number | endif
    autocmd WinLeave * setlocal nocursorline nonumber
augroup END

" }}}
" Allow color schemes to do bright colors without forcing bold {{{
if &t_Co == 8 && $TERM !~# '^linux\|^Eterm'
  set t_Co=16
endif

" }}}
" Command Window options {{{
augroup CommandWindow
    autocmd!
    " have <Ctrl-C> leave cmdline-window
    autocmd CmdwinEnter * nnoremap <silent> <buffer> <C-C> :<C-U>q<CR>
    autocmd CmdwinEnter * inoremap <silent> <buffer> <C-C> <Esc>:q<CR>
    " start command line window in insert mode and no line numbers
    autocmd CmdwinEnter * startinsert
    autocmd CmdwinEnter * set nonumber
    "autocmd BufReadPost *
                "\ if line("'\"") > 0 && line("'\"") <= line("$")
                "\| execute "normal g'\"" | endif
augroup END

" }}}

" }}}
" Abbrevs {{{
" Open help in a vertical split instead of the default horizontal split {{{
" " http://vim.wikia.com/wiki/Replace_a_builtin_command_using_cabbrev
cabbrev h <C-R>=(getcmdtype()==':' && getcmdpos()==1 ? 'vert h' : 'h')<CR>
cabbrev help <C-R>=(getcmdtype()==':' && getcmdpos()==1 ? 'vert h' : 'help')<CR>

" }}}
" Use :w!! to save a file with super-user permissions {{{
cabbrev w!! <C-R>=(getcmdtype()==':' && getcmdpos()==1 ? 'w !sudo tee % >/dev/null' : 'w!!')<CR>

" }}}
" Replace 'ddate' with current date, 'ttime' with current time {{{
if exists('*strftime')
    iabbrev ddate <C-R>=strftime('%m/%d/%Y')<CR>
    iabbrev ttime <C-R>=strftime('%Y-%m-%d %a %H:%M')<CR>
endif

" }}}
" PRNG from 'od' -- specify the number of bytes in the form 'randX' {{{
if executable('od')
    for n in [1,2,4,8]
        execute 'iabbrev rand'.n." \<C-R>=system('". 'od -vAn -N'.n.
                    \' -tu'.n.' </dev/urandom \| tr -d "\n\r \t"'."')\<CR>"
    endfor
endif

" }}}
" }}}
" Mappings  {{{
" Mapping to show which lines exceed textwidth/95 columns {{{
exe 'nnoremap <silent> <Leader>n /\%>'
            \ . (&textwidth == 0 ? 81 : (&textwidth + 1))
            \ . 'v.\+<cr>'
exe 'nnoremap <silent> <Leader>N ?\%>'
            \ . (&textwidth == 0 ? 81 : (&textwidth + 1))
            \ . 'v.\+<cr>'

" }}}
" Map annoying and useless <F1>, Q, and K to more useful things {{{
" - <F1> unmapped so it can be used outside of vim for changing tmux windows
" - Q repeats the last macro used, making using macros more convenient
" - K splits the line and removes trailing whitespace (reverse of J/gJ)
nnoremap <F1> <Nop>
nnoremap Q @@
function! s:Split() abort
    execute "normal! i\<CR>\<Esc>k$"
    if getline(line('.'))[col('.')-1] =~ '\s'
        execute 'normal! "_diw'
    else
        execute 'normal! g_'
    endif
endfunction
nnoremap <silent> K :<C-U>call <SID>Split()<Bar>silent! call repeat#set('K',-1)<CR>
nnoremap gK i<CR><Esc>kg_

" }}}
" Fly through buffers {{{
nnoremap gb :<C-U>ls<CR>:<C-U>b<Space>

" }}}
" Use <leader>? to toggle between always going down with n & up with N {{{
" or the default behavior
if !exists('g:next_direction_fixed')
    let g:next_direction_fixed = 1
endif
function! s:Toggle_n_N_behavior() abort
    if g:next_direction_fixed
        nunmap n
        nunmap N
        let g:next_direction_fixed = 0
    else
        nnoremap n /<C-U><CR>
        nnoremap N ?<C-U><CR>
        let g:next_direction_fixed = 1
    fi
endfunction
nnoremap <Leader>? :<C-U>call <SID>Toggle_n_N_behavior()<CR>

" }}}
" Keymaps to evaluate floating point math in place {{{
" ("math after" and "math replace")
if executable('perl')
    nnoremap <Leader>ma yyp^y$V:!perl -e '$x = <C-R>"; print $x'<CR>-y0j0P
    vnoremap <Leader>ma yo<Esc>p^y$V:!perl -e '$x = <C-R>"; print $x'<CR>-y0j0P
    nnoremap <Leader>mr ^"gy0^y$V:!perl -e '$x = <C-R>"; print $x'<CR>^"gP
    vnoremap <Leader>mr "aygvrXgv"by:r !perl -e '$x = <C-R>a; print $x'<CR>0"cyWddk:s/<C-R>b/<C-R>c/<CR>
endif

" }}}
" Use <leader>q to quit nameless buffers without confirmation or ! {{{
nnoremap <silent> <Leader>q :<C-U>call QuitIfNameless()<CR>
function! QuitIfNameless() abort
    if empty(bufname('%'))
        setlocal nomodified
    endif
    execute 'confirm quit'
endfunction

" }}}
" Use 'verymagic' search {{{
" Does not apply to substitutions; if you want to verymagic your substitutions,
" use the last search register or add \v manually
nnoremap / /\v
nnoremap ? ?\v

" }}}
" Relative number toggle {{{
nnoremap <silent> <Leader>r :<C-U>set relativenumber!<CR>

" }}}
" Newline without leading characters (e.g. comment chars) {{{
inoremap <C-J> <CR><C-U>

" }}}
" Allow redo for insert mode ^u {{{
inoremap <C-U> <C-G>u<C-U>

" }}}
" File Editing Keymaps: {{{
nnoremap <silent> <Leader>/ :<C-U>nohlsearch<CR>
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

" }}}
" Source VimScript Keymaps: {{{
nnoremap <silent> <Leader>sv :<C-U>so $MYVIMRC<CR>
nnoremap <silent> <Leader>sll yy:execute @@<CR>
xnoremap <silent> <Leader>sl y:execute @@<CR>
function! SourceThis(type, ...) abort
    let reg_save = @"
    silent! execute "normal! g`[y" . (a:type #== 'line' ? 'V' : 'v') . "g`]"
    execute @"
    let @" = reg_save
endfunction
nnoremap <silent> <Leader>sl :set opfunc=SourceThis<CR>g@

" }}}
" Remap m to save the file -- I don't use manual marks much anyway {{{
nnoremap <silent> m :<C-U>update!<CR>

" }}}
" Open a Quickfix window for the last search. {{{
nnoremap <silent> <Leader>? :<C-U>execute 'vimgrep /'.@/.'/g %'<CR>:copen<CR>

" }}}
" Delete to black hole register {{{
nnoremap <silent> <Leader>d "_d

" }}}
" Switch buffers with a count: 3! will switch to buffer 3 {{{
" Delete buffers the same way with ~
nnoremap <expr> ! v:count ? ":<C-U>b<C-R>=v:count<CR><CR>" : "!"
nnoremap <expr> ~ v:count ? ":<C-U>bd!<C-R>=v:count<CR><CR>" : "~"

" }}}
" Use the more intuitive + and - for incrementing and decrementing numbers {{{
noremap + <C-A>
noremap - <C-X>

" }}}
" Set Y to match C and D syntax (use yy to yank entire line) {{{
nnoremap Y y$

" }}}
" Let gy/gY match gp/gP; with gY matching C and D syntax {{{
nnoremap gY Dp
function! Opfunc_gy(type, ...) abort
    let sel_save = &selection
    let &selection = "inclusive"
    if a:0  " Invoked from Visual mode, use gv command.
        silent exe "normal! gvy`]"
    elseif a:type == 'line'
        silent exe "normal! '[V']y`]$hl"
    else
        silent exe "normal! `[v`]y`]"
    endif
    let &selection = sel_save
endfunction
nnoremap <silent> gy :set opfunc=Opfunc_gy<CR>g@
nnoremap <silent> gyy 0Dp
xnoremap <silent> gy :<C-U>call Opfunc_gy(visualmode(), 1)<CR>

" }}}
" Go to last location when using gf and <C-^> {{{
noremap gf gf`"
noremap <C-^> <C-^>`"

" }}}
" Remap: gH/gL to H/L to {/} to ^/$ {{{
" Hitting { and } constantly gets painful, and ^ and $ are too useful to be so
" inconvenient. The normal H and L have been offloaded to gH and gL. I use
" keepjumps in normal mode so H and L don't write to the jumplist, and add V to
" operator-pending mode so the motion acts linewise instead of characterwise
xnoremap  L  }
onoremap  L V}
 noremap gL L
nnoremap <silent> L :<C-U>execute 'keepjumps normal!' v:count1 . '}'<CR>
xnoremap  H  {
onoremap  H V{
 noremap gH H
nnoremap <silent> H :<C-U>execute 'keepjumps normal!' v:count1 . '{'<CR>
 noremap { ^
 noremap } $

" }}}
" Type 'cd' to change vim's working directory to that of the current buffer {{{
nnoremap cd :cd %:h<CR>

" }}}
" Auto fold lines matching last search pattern {{{
" Only works with marker & manual folding
nnoremap <silent> zF :setlocal foldexpr=(getline(v:lnum)=~@/)?0:(getline(v:lnum-1)=~@/)\\|\\|(getline(v:lnum+1)=~@/)?0:1 foldmethod=expr foldlevel=0 foldcolumn=1<CR>
set foldopen-=search " Disable opening folds when a search match is found inside
set foldopen-=block  " Disable opening folds when moving to block markers

" }}}
" Force expected behavior when traversing wrapped lines {{{
 noremap  j  gj
onoremap  j Vgj
 noremap gj   j
 noremap  k  gk
onoremap  k Vgk
 noremap gk   k

" }}}
" DoWordMotion: Fix Vim's crazy cw & cW maps {{{
" Based on github.com/ap/vim-you-keep-using-that-word
function! s:DoWordMotion(motion) abort
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
onoremap <silent> <Plug>DoWordMotion :<C-U>silent! call <SID>DoWordMotion('w')<CR>
onoremap <silent> <Plug>DoWORDMotion :<C-U>silent! call <SID>DoWordMotion('W')<CR>
omap w <Plug>DoWordMotion
omap W <Plug>DoWORDMotion

" }}}
" Hex Mode Toggling: {{{
" The following maps the F8 key to toggle between hex and binary (while also
" setting the noeol and binary flags, so if you :write your file, vim doesn't
" perform unwanted conversions.

let $in_hex=0
function! HexMe() abort
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
nnoremap <F8> :call HexMe()<CR>

" }}}
" Matchit: {{{
" Load matchit.vim if available and not yet loaded
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

" }}}

" }}}
" Autocommands {{{
" Filetype Specific Autocommands: {{{
filetype on
augroup filetype_commands
    autocmd!
    " Syntax of these languages is fussy over tabs Vs spaces
    au FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
    au FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

    au FileType html,css setlocal ts=2 sts=2 sw=2 et
                    \ omnifunc=htmlcomplete#CompleteTags
                    \| iabbrev </ </<C-x><C-o>
        au FileType sml setlocal makeprg="mosmlc %"
        au FileType c,cpp,javascript,slang setlocal cindent fo+=r
        au FileType javascript,javascript.jsx setlocal ts=2 sts=2 sw=2 et
    au FileType actionscript,asciidoc,autohotkey,b,c,cpp,cs,d,go,java,javascript,cocoa,php,pli,rust,scala,sass,sql,swift,prolog,css
                \ setlocal comments-=s1:/*,mb:*,ex:*/ comments+=s:/*,mb:\ *,ex:\ */,fb:*

    au FileType asciidoc set makeprg=make\ %:r:S.html

    au FileType vim set fen fdm=marker fmr=\ {{{,\ }}}

        au FileType crontab setlocal backupcopy=yes
    au BufEnter *.{md,markdown} setfiletype=markdown

    " Fix syntax highlighting of vim helpfiles, since 'modeline' is off
    au BufEnter */{,.}vim/*/{doc,macros}/*.txt setfiletype help

    " Treat .rss files as XML
    au BufNewFile,BufRead *.rss setfiletype xml

    " When no filetype is given use "text" by default
    au BufRead,BufNewFile * setfiletype text

    au BufRead,BufNewFile *.{vhd,vhdl} setfiletype=vhdl
    au FileType vhdl   setlocal commentstring=--%s
                \ makeprg=vlib\ work\;\ vcom\ %
                \ errorformat=**\ Error:\ %f(%l):\ %m

    au BufNewFile,BufRead /dev/shm/gopass.* setlocal noswapfile nobackup noundofile

    au FileType python setlocal ts=4 sts=4 sw=4 et
    au FileType ruby   setlocal ts=2 sts=2 sw=2 et
augroup END

" Nice defaults for txt files " {{{
" hattip to /u/ghost-in-a-shell @ redd.it/4lvaok
function! s:PlainText() abort
    " Formatting
    setl comments=
    setl commentstring=>\ %s
    setl spell
    setl wrap
    setl textwidth=95
    setl formatoptions+=tcoqnl1j
    setl linebreak
    setl breakindent
    "setl &showbreak = '└ '
    " Better indention/ hierarchy
    setl formatlistpat=^\\s*                    " Optional leading whitespace
    setl formatlistpat+=[                       " Start class
    setl formatlistpat+=\\[({]\\?               " |  Optionally match opening punctuation
    setl formatlistpat+=\\(                     " |  Start group
    setl formatlistpat+=[0-9]\\+                " |  |  A number
    setl formatlistpat+=\\\|[iIvVxXlLcCdDmM]\\+ " |  |  Roman numerals
    setl formatlistpat+=\\\|[a-zA-Z]            " |  |  A single letter
    setl formatlistpat+=\\)                     " |  End group
    setl formatlistpat+=[\\]:.)}                " |  Closing punctuation
    setl formatlistpat+=]                       " End class
    setl formatlistpat+=\\s\\+                  " One or more spaces
    setl formatlistpat+=\\\|^\\s*[-–+o*]\\s\\+  " Or ASCII style bullet points
endfunction

augroup txt_defaults
    autocmd!
    autocmd FileType text call <SID>PlainText()
augroup END

"}}}

" }}}
" Center the cursor line {{{
nnoremap <silent> <Leader><Leader> :let &scrolloff=999-&scrolloff<CR>
augroup CenteringReadOnly
    autocmd!
    autocmd BufEnter * if !&modifiable | setlocal scrolloff=999 | endif
augroup END

" }}}
" iTerm only: change cursor shape for insert vs normal mode {{{
if $TERM_PROGRAM == 'iTerm.app'
    if exists('$TMUX')
        let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
        let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
    else
        let &t_SI = "\<Esc>]50;CursorShape=1\x7"
        let &t_EI = "\<Esc>]50;CursorShape=0\x7"
    endif
endif

" }}}
" Trailing Whitespace Handling {{{
function! s:DisableWhitespace() abort
    silent! autocmd! AnnoyingWhitespace
    silent! syn clear EOLWS
    call clearmatches()
endfunction

function! s:EnableWhitespace() abort
    silent! call <SID>DisableWhitespace()
    highlight default link EOLWS ErrorMsg
    execute 'syn match EOLWS /\s\+$/'
    augroup AnnoyingWhitespace
        autocmd!
        autocmd InsertEnter * syn clear EOLWS
                    \ | execute 'syn match EOLWS excludenl /\v\s+%#@!$/'
        autocmd BufWinEnter,InsertLeave * syn clear EOLWS
                    \ | execute 'syn match EOLWS excludenl /\s\+$/'
        autocmd BufWinLeave * syn clear EOLWS
    augroup END
endfunction

function! s:StripWhitespace() abort
    silent! let ishls=v:hlsearch
    let lastsearch=@/
    let pos=getpos('.')
    execute '%s/\s\+$//e'
    let @/=lastsearch
    silent! let v:hlsearch=ishls
    call setpos('.',pos)
endfunction

let g:trailing_ws_blacklist = ['diff', 'gitcommit', 'unite', 'qf', 'help', 'markdown', 'calendar']

function! s:AutoEnableWS() abort
    if index(g:trailing_ws_blacklist, &ft) == -1
        call <SID>EnableWhitespace()
    else
        call <SID>DisableWhitespace()
    endif
endfunction

augroup TrailingWS
    autocmd!
    autocmd VimEnter,WinEnter,BufWinEnter,BufEnter * call <SID>AutoEnableWS()
    autocmd BufLeave * call <SID>DisableWhitespace()
augroup END

command! -nargs=0 EnableWhitespace  call <SID>EnableWhitespace()
command! -nargs=0 DisableWhitespace call <SID>DisableWhitespace()
command! -nargs=0 StripWhitespace   call <SID>StripWhitespace()
nnoremap <silent> <Plug>ClearWhitespace :<C-U>call <SID>StripWhitespace()<CR>
nmap <Leader>cws <Plug>ClearWhitespace

" }}}
" EasyDir: automatically create parent directories when saving a new file {{{
function! <SID>create_and_save_directory() abort
  let s:directory = expand('<afile>:p:h')
  if s:directory !~# '^\(scp\|ftp\|dav\|fetch\|ftp\|http\|rcp\|rsync\|sftp\|file\):'
  \ && !isdirectory(s:directory)
    call mkdir(s:directory, 'p')
  endif
endfunction

augroup EasyDir
  autocmd!
  autocmd BufWritePre,FileWritePre * call <SID>create_and_save_directory()
augroup END

" }}}
" Remember cursor position {{{
function! ResCur() abort
    if line("'\"") <= line("$")
        silent! normal! g`"
    endif
endfunction
augroup resCur
    autocmd!
    autocmd BufWinEnter * call ResCur()
augroup END

" The following saves and loads buffers' foldview settings between sessions {{{
" All this code originates from https://github.com/vim-scripts/restore_view.vim
" which itself originates from the vim wiki http://vim.wikia.com/wiki/VimTip991
if !exists("g:skipview_files")
    let g:skipview_files = []
endif
function! MakeViewCheck() abort
    if &l:diff | return 0 | endif
    if &buftype != '' | return 0 | endif
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
    autocmd BufWritePre,BufWinLeave ?* if MakeViewCheck() | silent! mkview | endif
    autocmd BufWinEnter ?* if MakeViewCheck() | silent! loadview | endif
augroup END

" }}}

" }}}
