" vimrc
" vim:set ft=vim tw=80 sw=4 et

let g:mapleader = " "
nnoremap <Space> <Nop>

" Plugins And Settings:
if filereadable(expand('~/dotfiles/bundles.vim')) &&
            \ filereadable(expand('~/dotfiles/plugins.vim'))
    source ~/dotfiles/bundles.vim
    source ~/dotfiles/plugins.vim
endif
filetype plugin indent on

set backspace=indent,eol,start                      " Allow backspacing anywhere
set splitbelow splitright                 " Split windows below and to the right
set wildmenu wildmode=list:longest,full                 " Cmdline tab completion
set wildignore=*.o,*~,*.pyc,*.obj,*.a,*.lib,*.elf        " Ignore non-text files
set wildignore+=*.swp,*~,._* backup noswapfile                 " Remove swapfile
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
set shell=/bin/sh                                                " Default shell
set t_ut=                    " Clear using background color -- fix tmux coloring
set mouse=a ttymouse=xterm2                                      " Mouse support
set nowrap linebreak textwidth=80 " Text wrapping: break line along spaces @~80c
set encoding=utf8 fileformats=unix,dos,mac          " Supported document formats
set foldmethod=manual foldnestmax=3 nofoldenable foldcolumn=0            " Folds
set diffopt=filler,vertical,foldcolumn:2                               " Vimdiff
set scrolloff=4 sidescrolloff=0                           " Scrolling boundaries
set number norelativenumber                                       " Line numbers
set autowrite                       " Automatically save file when focus is lost
set copyindent autoindent          " Imitate indenting of previous line's indent
set ttyfast                                            " See :help slow-terminal
set switchbuf=useopen               " Switch to open buffer instead of reopening
set viewoptions=folds,options,cursor,unix,slash                     " Appearance
set laststatus=2                                    " Always display status line
set noshowmode         " Don't show -- INSERT -- or whatever in the command line
set noerrorbells novisualbell                               " No annoying alerts
set viminfo='20,\"50,:10,/10,%,n~/.viminfo    " Remember things between sessions
set sessionoptions=blank,buffers,curdir,folds,help,options,winsize,tabpages
set winwidth=86   " Minimum split width -- 80 + 6 for number + sign/fold columns
set nojoinspaces          " Don't add extra spaces after .?! when joining with J
set equalalways         " Make current split be always at least "textwidth" wide
set cryptmethod=blowfish                     " Slightly more secure cryptography
set path=.,**        " Make :find, :sfind, :vert sfind search parent directories

if exists('+breakindent') | set breakindent | endif

" Syntax Highlighting:
syntax enable                                      " Turn on syntax highlighting
syntax sync minlines=256            " Update syntax highlighting for more lines
set synmaxcol=512                            " Don't syntax highlight long lines
" Default paren match highting is too distracting
highlight! link MatchParen Comment

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

set autoread          " Reread a file detected to have been modified outside Vim
augroup AutoReading
    autocmd!
    autocmd CursorHold,CursorHoldI * checktime
augroup END

augroup Resize                    " Make splits equal size, unless in focus mode
    autocmd!
    autocmd WinEnter,VimResized * if &l:ft != 'focusmode' | wincmd = | endif
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

" Settings for Vi-compatible behavior (Vim default: aABceFs)
" Note: this list is not exhaustive. See :h 'cpo'
 set cpoptions=
"set cpo+=a " :read  command with a file name arg will modify the window's alternate file name
"set cpo+=A " :write command with a file name arg will modify the window's alternate file name
 set cpo+=B " Give backslash no special meaning in mappings, abbreviations and the 'to' part of the menu commands
 set cpo+=c " Searching continues at the end of any match at the cursor position, but not further than the start of the next line.  When not present searching continues one character from the cursor position.  With 'c' 'abababababab' only gets three matches when repeating /abab', without 'c' there are five matches.
 set cpo+=e " When executing a register with ':@r', always add a <CR> to the last line, even when the register is not linewise
 set cpo+=F " :write with a file name argument will set the file name for the current buffer if it doesn't have one already
"set cpo+=i " Interrupting the reading of a file will leave it modified.
 set cpo+=K " Don't wait for a key code to complete
"set cpo+=m " 'Showmatch' will always wait half a second, even if a character is typed within that time period
 set cpo+=q " Joining multiple lines leaves the cursor where it would be when joining two lines
 set cpo+=s " Set buffer options when first entering the buffer instead of when it's created
"set cpo+=t " Search pattern for the tag command is remembered for 'n' command
 set cpo+={ " The |{| and |}| commands also stop at a '{' character at the start of a line.

if v:version > 703 || v:version == 703 && has("patch541")
    set formatoptions+=j
endif

" Highlight last column so we know when we're over
if exists('+colorcolumn')
    if &textwidth != 0
        set colorcolumn=+1
    else
        set colorcolumn=81
    endif
elseif has("autocmd") " Highlight text that's over our limit
    highlight link OverLength ErrorMsg
    augroup OverLengthCol
        autocmd!
        autocmd BufEnter,BufWrite *
                    \ execute 'match OverLength /\%>'
                    \ . (&textwidth == 0 ? 80 : &textwidth)
                    \ . 'v.\+/'
    augroup END
endif
exe 'nnoremap <silent> <Leader>n /\%>'
            \ . (&textwidth == 0 ? 81 : (&textwidth + 1))
            \ . 'v.\+<cr>'
exe 'nnoremap <silent> <Leader>N ?\%>'
            \ . (&textwidth == 0 ? 81 : (&textwidth + 1))
            \ . 'v.\+<cr>'

" Remember undo history
if exists("+undofile")
    if !isdirectory($HOME . '/.vim/undo')
        silent !mkdir -p ~/.vim/undo > /dev/null 2>&1
    endif
    set undodir=./.vim-undo//
    set undodir+=~/.vim/undo//
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
if has("gui_running")
    set guioptions=c " Least obtrusive gui possible
    if has("gui_gtk2")
        set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 12
    elseif has("gui_macvim")
        set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:12
    elseif has("gui_win32")
        set guifont=DejaVu_Sans_Mono_for_Powerline:12
    end
    set guitablabel=%M\ %t
else
    " Remove small delay between pressing Esc and entering Normal mode.
    set ttimeout
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
nnoremap <silent> <Plug>Split :<C-u>call Split()<CR>:<C-u>silent! call repeat#set("\<Plug>Split")<CR>
nmap K <Plug>Split
nnoremap <silent> K :<C-u>call Split()<CR>
function! Split()
    " The 'hl' is there to keep the cursor from becoming right-aligned
    execute "normal! i\<CR>\<Esc>k$hl"
    if getline(line('.'))[col('.')-1] =~ '\s'
        execute 'normal! "_diw'
    endif
endfunction

" Make cw consistent with dw, yw, vw
onoremap w :execute 'normal! '.v:count1.'w'<CR>

" Open help in a vertical split instead of the default horizontal split
" " http://vim.wikia.com/wiki/Replace_a_builtin_command_using_cabbrev
cabbrev h <C-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'vert h' : 'h')<CR>
cabbrev help <C-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'vert h' : 'help')<CR>

" Use :w!! to save a file with super-user permissions
cabbrev w!! <C-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'w !sudo tee % >/dev/null' : 'w!!')<CR>

" Use ,q to quit nameless buffers without confirmation or !
nnoremap <silent> <Leader>q :<C-u>call QuitIfNameless()<CR>
function! QuitIfNameless()
    if empty(bufname('%'))
        setlocal nomodified
    endif
    execute 'confirm quit'
endfunction

" Replace 'ddate' with current date, 'ttime' with current time
if exists("*strftime")
    iabbrev ddate <C-r>=strftime("%m/%d/%Y")<CR>
    iabbrev ttime <C-r>=strftime("%Y-%m-%d %a %H:%M")<CR>
endif

" Use 'verymagic' search. Does not apply to substitutions; if you want to
" verymagic your substitutions, use the last search register or add \v manually
nnoremap / /\v
nnoremap ? ?\v

" Add a relative number toggle
nnoremap <silent> <Leader>r :<C-u>set relativenumber!<CR>

" Newline without automatically adding leading characters (e.g. comment chars)
inoremap <C-j> <CR><C-u>

" Allow redo for insert mode ^u
inoremap <C-u> <C-g>u<C-u>

nnoremap <silent> <Leader>/ :<C-u>nohlsearch<CR>
nnoremap <silent> <Leader>w :<C-u>update!<CR>
if isdirectory(expand('~/dotfiles'))
    nnoremap <silent> <Leader>ev :<C-u>vsplit ~/dotfiles/vimrc<CR>
    nnoremap <silent> <Leader>eb :<C-u>vsplit ~/dotfiles/bundles.vim<CR>
    nnoremap <silent> <Leader>ep :<C-u>vsplit ~/dotfiles/plugins.vim<CR>
    nnoremap <silent> <Leader>ez :<C-u>vsplit ~/dotfiles/zshrc<CR>
    nnoremap <silent> <Leader>ea :<C-u>vsplit ~/dotfiles/aliases.zsh<CR>
else
    nnoremap <silent> <Leader>ev :<C-u>vsplit ~/.vimrc<CR>
    nnoremap <silent> <Leader>ez :<C-u>vsplit ~/.zshrc<CR>
endif
nnoremap <silent> <Leader>el :<C-u>vsplit ~/.localrc.zsh<CR>
nnoremap <silent> <Leader>sv :<C-u>so $MYVIMRC<CR>
nnoremap <silent> <Leader>sll yy:execute @@<CR>
xnoremap <silent> <Leader>sl y:execute @@<CR>gv<esc>
function! SourceMe(...)
    let a_reg = @a
    norm! `["ay`]
    echo ''
    exe @a
    let @a = a_reg
endfunction
nnoremap <silent> <Leader>sl :set opfunc=SourceMe<CR>g@

nnoremap <silent> m :<C-u>update!<CR>

" Open a Quickfix window for the last search.
nnoremap <silent> <Leader>? :execute 'vimgrep /'.@/.'/g %'<CR>:copen<CR>

" Delete to black hole register
nnoremap <silent> <Leader>d "_d

" Switch buffers with a count: 3! will switch to buffer 3
" Delete buffers the same way with ~
nnoremap <expr> ! v:count ? ":<C-u>b<C-r>=v:count<CR><CR>" : "!"
nnoremap <expr> ~ v:count ? ":<C-u>bd!<C-r>=v:count<CR><CR>" : "~"

if has("autocmd")
    filetype on

    augroup filetype_commands
        autocmd!
        " Syntax of these languages is fussy over tabs Vs spaces
        au FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
        au FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

        au FileType html       setlocal ts=8
        au FileType css        setlocal ts=8
        au FileType javascript setlocal noet
        au FileType sml        setlocal makeprg="mosmlc %"
        au FileType c,cpp,javascript,slang setlocal cindent fo+=r
        au FileType javascript,html,xhtml,css,php setlocal sw=2 tw=2 fdm=indent

        " Fix syntax highlighting of vim helpfiles, since 'modeline' is off
        au BufEnter *.txt
            \ if expand('%:p:h') =~? '.*/\.\?vim/.*/(doc|macros)' | setfiletype help | endif

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
" keepjumps in normal mode so H and L don't write to the jumplist, and add V to
" operator-pending mode so the motion acts linewise instead of characterwise
xnoremap L }
xnoremap H {
onoremap L V}
onoremap H V{
nnoremap <silent> L :<C-u>execute 'keepjumps normal!' v:count1 . '}'<CR>
nnoremap <silent> H :<C-u>execute 'keepjumps normal!' v:count1 . '{'<CR>
noremap { ^
noremap } $

nnoremap <silent> <Leader><Leader> :let &scrolloff=999-&scrolloff<CR>
augroup CenteringReadOnly
    autocmd!
    autocmd BufEnter * if !&modifiable | setlocal scrolloff=999 | endif
augroup END

nnoremap <silent> zS :setlocal foldexpr=(getline(v:lnum)=~@/)?0:(getline(v:lnum-1)=~@/)\\|\\|(getline(v:lnum+1)=~@/)?1:2 foldmethod=expr foldlevel=0 foldcolumn=2<CR>
set foldopen-=search

" Allow expected behavior when traversing wrapped lines
noremap j gj
onoremap j Vgj
noremap k gk
onoremap k Vgk
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

" The following saves and loads buffers' foldview settings between sessions {{{
" All this code originates from https://github.com/vim-scripts/restore_view.vim
" which itself originates from the vim wiki http://vim.wikia.com/wiki/VimTip991
if exists("g:loaded_restore_view")
    finish
endif
let g:loaded_restore_view = 1
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

" Set a nicer foldtext function {{{
function! MyFoldText()
  let line = getline(v:foldstart)
  if match( line, '^[ \t]*\(\/\*\|\/\/\)[*/\\]*[ \t]*$' ) == 0
    let initial = substitute( line, '^\([ \t]\)*\(\/\*\|\/\/\)\(.*\)', '\1\2', '' )
    let linenum = v:foldstart + 1
    while linenum < v:foldend
      let line = getline( linenum )
      let comment_content = substitute( line, '^\([ \t\/\*]*\)\(.*\)$', '\2', 'g' )
      if comment_content != ''
        break
      endif
      let linenum = linenum + 1
    endwhile
    let sub = initial . ' ' . comment_content
  else
    let sub = line
    let startbrace = substitute( line, '^.*{[ \t]*$', '{', 'g')
    if startbrace == '{'
      let line = getline(v:foldend)
      let endbrace = substitute( line, '^[ \t]*}\(.*\)$', '}', 'g')
      if endbrace == '}'
        let sub = sub.substitute( line, '^[ \t]*}\(.*\)$', '...}\1', 'g')
      endif
    endif
  endif
  let n = v:foldend - v:foldstart + 1
  let info = " " . n . " lines"
  let sub = sub . "                                                                                                                  "
  let num_w = getwinvar( 0, '&number' ) * getwinvar( 0, '&numberwidth' )
  let fold_w = getwinvar( 0, '&foldcolumn' )
  let tw = (&tw > 0 ? &tw : 80)
  let ww = winwidth(0)
  let width = (ww > tw ? tw : ww)
  let sub = strpart( sub, 0, width - strlen( info ) - num_w - fold_w - 1 )
  return sub . info
endfunction
set foldtext=MyFoldText()
" }}}

" Stolen from github.com/tpope/vim-scriptease {{{
function! s:opfunc(type) abort
  let sel_save = &selection
  let cb_save = &clipboard
  let reg_save = @@
  try
    set selection=inclusive clipboard-=unnamed clipboard-=unnamedplus
    if a:type =~ '^\d\+$'
      silent exe 'normal! ^v'.a:type.'$hy'
    elseif a:type =~# '^.$'
      silent exe "normal! `<" . a:type . "`>y"
    elseif a:type ==# 'line'
      silent exe "normal! '[V']y"
    elseif a:type ==# 'block'
      silent exe "normal! `[\<C-V>`]y"
    else
      silent exe "normal! `[v`]y"
    endif
    redraw
    return @@
  finally
    let @@ = reg_save
    let &selection = sel_save
    let &clipboard = cb_save
  endtry
endfunction

function! s:filterop(type) abort
  let reg_save = @@
  try
    let expr = s:opfunc(a:type)
    let @@ = matchstr(expr, '^\_s\+').scriptease#dump(eval(s:gsub(expr,'\n%(\s*\\)=',''))).matchstr(expr, '\_s\+$')
    if @@ !~# '^\n*$'
      normal! gvp
    endif
  catch /^.*/
    echohl ErrorMSG
    echo v:errmsg
    echohl NONE
  finally
    let @@ = reg_save
  endtry
endfunction

nnoremap <silent> <Plug>ScripteaseFilter :<C-U>set opfunc=<SID>filterop<CR>g@
xnoremap <silent> <Plug>ScripteaseFilter :<C-U>call <SID>filterop(visualmode())<CR>
nmap g! <Plug>ScripteaseFilter
nmap g!! <Plug>ScripteaseFilter_
xmap g! <Plug>ScripteaseFilter
" }}}
