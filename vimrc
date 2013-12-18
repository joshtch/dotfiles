" Clear autocmd settings
if has("autocmd")
        autocmd!
endif

" NeoBundle plugin setup {{{
let neobundle_readme=expand('~/.vim/bundle/neobundle.vim/README.md')
if !filereadable(neobundle_readme)
        echo "Installing NeoBundle.."
        echo ""
        silent !mkdir -p ~/.vim/bundle
        silent !git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
endif
if has('vim_starting')
        set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

" Original repos on github
"Add your bundles here

"NeoBundle 'FredKSchott/CoVim'
"NeoBundle 'junegunn/vim-easy-align'
"NeoBundle 'ksenoy/vim-signature'
"NeoBundle 'osyo-manga/vim-over'
"NeoBundle 'supasorn/vim-easymotion'
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimproc'
NeoBundle 'Valloric/YouCompleteMe'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'benmills/vimux'
NeoBundle 'bling/vim-airline'
NeoBundle 'christoomey/vim-tmux-navigator'
NeoBundle 'dbakker/vim-lint'
NeoBundle 'godlygeek/tabular'
NeoBundle 'h1mesuke/unite-outline'
NeoBundle 'jtmkrueger/vim-c-cr'
NeoBundle 'justinmk/vim-sneak'
NeoBundle 'liujoey/vim-easymotion'
NeoBundle 'merlinrebrovic/focus.vim'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'spiiph/vim-space'
NeoBundle 'tpope/vim-capslock'
NeoBundle 'tpope/vim-obsession'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'tpope/vim-surround'
NeoBundle 'vim-scripts/Smooth-Scroll'
NeoBundle 'vim-scripts/taglist.vim'

" Installation check.
NeoBundleCheck
" }}}

" Solarized {{{
syntax enable
colorscheme solarized
set background=dark
call togglebg#map("<leader>5")
let g:solarized_termcolors=16
let g:solarized_termtrans=0
" }}}

" vim-airline settings {{{
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 10
set lazyredraw
set t_Co=256
set ttimeoutlen=50
let g:airline_powerline_fonts = 1
let g:airline_enable_synastic = 1
let g:airline_enable_fugitive = 0
let g:airline_modified_detection = 1
"let g:airline_left_sep = '▶'
"let g:airline_right_sep = '◀'
"let g:airline_linecolumn_prefix = '¶'
"let g:airline_fugitive_prefix = '⎇ '
let g:airline_theme = 'solarized'
let g:airline#extensions#tabline#enabled = 1
" }}}

" Syntastic {{{
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_filetype_map = { 'latex': 'tex' }
let g:syntastic_stl_format = '[%E{Err: %fe #%e}]'
let g:syntastic_list_height = 5
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '!'
let g:syntastic_c_check_header = 1
let g:syntastic_auto_refresh_includes = 1
let g:syntastic_c_compiler = 'gcc'
" }}}

" YouCompleteMe {{{
let g:ycm_confirm_extra_conf = 0
let g:ycm_key_detailed_diagnostics = ''
let g:ycm_register_as_syntastic_checker = 1
" }}}

" focus.vim {{{
function! CleanEmptyBuffers()
        let buffers = filter(range(0, bufnr('$')), 'buflisted(v:val) && empty(bufname(v:val)) && bufwinnr(v:val)<0')
        if !empty(buffers)
                exe 'bw '.join(buffers, ' ')
        endif
endfunction
nmap <leader>fmt <Plug>FocusModeToggle
nmap <silent> <leader>ceb :call CleanEmptyBuffers()<cr>
" }}}

" vim-space {{{
"noremap <expr> <silent> <Space> <SID>do_space(0, "<Space>")
"noremap <expr> <silent> <leader><Space> <SID>do_space(1, "<S-Space>")
" }}}

" Tabular.vim {{{
if exists(":Tabularize")
        "nmap <leader>a= :Tabularize /=<CR>
        "xmap <leader>a= :Tabularize /=<CR>
        "nmap <leader>a: :Tabularize /:\zs<CR>
        "xmap <leader>a: :Tabularize /:\zs<CR>
        "nmap <leader>ar :Tabularize /return<cr>
        "xmap <leader>ar :Tabularize /return<cr>
        function! s:tabularize_op(type, ...)
                let c = nr2char(getchar())
                execute "'[,']Tabularize/".c
        endfunction
        nnoremap <silent> <Leader>t :set opfunc=<SID>tabularize_op<Enter>g@
endif
" }}}

" Taglist {{{
if exists(':Tlist')
        nmap <leader>tl :TlistToggle<cr>
        nmap <leader>tf :ta<space>
        if filereadable('tags')
                set tags=tags
        endif
        if has("cscope") && filereadable("/usr/bin/cscope")
                set csprg=/usr/bin/cscope
                set csto=0
                set cst
                set nocsverb
                " add any database in current directory
                if filereadable("cscope.out")
                        cs add cscope.out
                        " else add database pointed to by environment
                elseif $CSCOPE_DB != ""
                        cs add $CSCOPE_DB
                endif
                set csverb
        endif
endif
" }}}

" vim-sneak {{{
hi link SneakPluginTarget ErrorMsg
hi link SneakPluginScope Comment
nmap - <Plug>SneakPrevious
nmap <leader>s <Plug>SneakForward
nmap <leader>S <Plug>SneakBackward
" }}}

" Vim-tmux-navigator {{{
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
nnoremap <silent> <c-l> :TmuxNavigateRight<cr>
nnoremap <silent> <c--> :TmuxNavigatePrevious<cr>
" }}}

" Vimux {{{
nmap <leader>vs :call VimuxRunCommand('exec zsh')<cr>:call VimuxRunCommand('clear')<cr>
nmap <leader>vc :VimuxCloseRunner<cr>
nmap <leader>vp :VimuxPromptCommand<cr>
nmap <leader>vr :VimuxRunLastCommand<cr>
" }}}

" Autolabel tmux windows
augroup Tmux
        au!
        autocmd VimEnter,BufNewFile,BufReadPost * call system('tmux rename-window "vim - ' . split(substitute(getcwd(), $HOME, '~', ''), '/')[-1] . '"')
        autocmd VimLeave * call system('tmux rename-window ' . split(substitute(getcwd(), $HOME, '~', ''), '/')[-1])
augroup END

" EasyMotion {{{
let g:EasyMotion_leader_key = '\'
hi EasyMotionTarget ctermbg=none ctermfg=red
hi EasyMotionTarget2First ctermbg=none ctermfg=red
hi link EasyMotionShade Comment
" }}}

" Open help in a vertical split instead of the default horizontal split
" " http://vim.wikia.com/wiki/Replace_a_builtin_command_using_cabbrev
cabbrev h <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'vert h' : 'h')<cr>
cabbrev help <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'vert h' : 'help')<cr>

" Still havent jumped on the NerdTree bandwagon
" Toggle Vexplore with Ctrl-E {{{
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
map <silent> <C-E> :call ToggleVExplorer()<CR>
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

" Unite {{{
let g:unite_source_history_yank_enable = 1
call unite#filters#matcher_default#use(['matcher_fuzzy'])
nnoremap <leader>t :<C-u>Unite -no-split -buffer-name=files   -start-insert file_rec/async:!<cr>
nnoremap <leader>f :<C-u>Unite -no-split -buffer-name=files   -start-insert file<cr>
nnoremap <leader>u :<C-u>Unite -no-split -buffer-name=mru     -start-insert file_mru<cr>
nnoremap <leader>o :<C-u>Unite -no-split -buffer-name=outline -start-insert outline<cr>
nnoremap <leader>y :<C-u>Unite -no-split -buffer-name=yank    history/yank<cr>
nnoremap <leader>e :<C-u>Unite -no-split -buffer-name=buffer  buffer<cr>

" Custom mappings for the unite buffer
autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
        " Play nice with supertab
        let b:SuperTabDisabled=1
        " Enable navigation with control-j and control-k in insert mode
        "imap <buffer> <C-j>   <Plug>(unite_select_next_line)
        "imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
endfunction
" Allow quitting unnamed buffers without confirmation or !
nnoremap <leader>q :call QuitIfEmpty()<CR>:q<Cr>
function! QuitIfEmpty()
        if empty(bufname('%'))⋅
                setlocal nomodified⋅
        endif
endfunction
" }}}

" Allow backspacing anywhere
set backspace=indent,eol,start

" Split windows below and to the right by default
set splitbelow
set splitright

" cmdline tab completion settings
set wildmode=list:longest,full
set wildmenu
set wildignore=*.o,*~,*.pyc,*.obj,*.a,*.lib,*.elf

" Command bar appearance modifications
set showcmd
set showmode
set cmdheight=1
set shortmess=atIfilmnrxoOT

" Highlight screen line of the cursor
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

" Defines bases for numbers for <c-a> and <c-x>
set nrformats=octal,hex,alpha

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
set tabstop=8

" Number of spaces that a <Tab> counts for for >>, <<, etc
set softtabstop=8

" Tabbing settings
set shiftwidth=8 " Number of spaces to tab by
set expandtab    " Change <Tab>s to spaces
set smarttab     " Tab inserts shiftwidth spaces, and backspace
set shiftround   " Round indents to multiple of 'shiftwidth'

" Disable temp and backup files
set wildignore+=*.swp,*~,._*
" Don't backup files.
set nobackup
set noswapfile

" Indent Guides plugin: alternates coloring of indent levels
let indent_guides_enable_on_vim_startup = 1

" Smart autoindenting
set autoindent
set cindent
"set smartindent " -- Deprecated
filetype plugin indent on

" Make trailing whitespace annoyingly highlighted.
" See: http://vim.wikia.com/wiki/Highlight_unwanted_spaces
augroup AnnoyingWhitespace
        autocmd!
        highlight link ExtraWhitespace ErrorMsg
        match ExtraWhitespace /\v\s+$/
        autocmd BufWinEnter * match ExtraWhitespace /\v\s+$/
        autocmd InsertEnter * match ExtraWhitespace /\v\s+%#@<!$/
        autocmd InsertLeave * match ExtraWhitespace /\v\s+$/
        autocmd BufWinLeave * call clearmatches()
        autocmd InsertEnter * syn clear EOLWS | syn match EOLWS excludenl /\v\s+%#@!$/
        autocmd InsertLeave * syn clear EOLWS | syn match EOLWS excludenl /\v\s+$/
        highlight link EOLWS ErrorMsg
augroup END

" Set default shell to use
set shell=/bin/zsh

" Show whitespace
set list
set listchars=
set listchars+=tab:▶\
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
nnoremap <leader>r :set rnu!<CR>

" Rereads a file when it is detected to have been modified outside Vim
set autoread

" Automatically save file when focus is lost
"augroup AutoSave
        "autocmd!
        "autocmd FocusLost * bufdo if expand('%') != '' | update | endif
"augroup END
set autowrite

" Autoindent imitates indenting of previous line's indent
set copyindent

" Off to avoid unnecessary security vulnerabilities
set modelines=0

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
inoremap <C-u> <C-g>u<C-u>

" Prevent Vim from clearing the scrollback buffer
" http://www.shallowsky.com/linux/noaltscreen.html
"set t_ti= t_te=

let mapleader = ","
let g:mapleader = ","
" Since the ',' operator is actually useful, we set it to ',;'
nnoremap <leader>; ,
nnoremap <leader>/ :set hlsearch! hlsearch?<CR>
nnoremap <leader>w :w!<cr>
nnoremap <silent> <leader>ev :vsplit $MYVIMRC<CR>
nnoremap <silent> <leader>ez :vsplit ~/.zshrc<CR>
nnoremap <silent> <leader>sl ^vg_y:execute @@<CR>
nnoremap <silent> <leader>ea :vsplit ~/.oh-my-zsh/lib/aliases.zsh<CR>
nnoremap <silent> <leader>sv :so $MYVIMRC<CR>

" Switch buffers with a count: 3! will switch to buffer 3
" Delete buffers the same way with ~
nnoremap <expr> ! v:count ? ":<C-u>b<C-r>=v:count<CR><CR>" : "!"
nnoremap <expr> ~ v:count ? ":<C-u>bd<C-r>=v:count<CR><CR>" : "~"
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
                autocmd FileType c setlocal ts=8 sts=8 sw=8 cindent expandtab
                autocmd FileType c setlocal makeprg=sh\ compile

                " Treat .ums files as UM assembly language
                autocmd BufNewFile,BufRead *.ums setfiletype ums
                autocmd BufNewFile,BufRead *.ums nnoremap <buffer> <leader>m :call VimuxRunCommand("sh compile")<cr>
                autocmd BufNewFile,BufRead *.ums nnoremap <buffer> <silent> <leader>g :call VimuxRunCommand("./um calc40.um")<cr>:VimuxInspectRunner<cr>

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

" Easier split switching -- Deprecated by vim-tmux-navigation
"nnoremap <silent> <C-J> <C-W>j
"nnoremap <silent> <C-K> <C-W>k
"nnoremap <silent> <C-H> <C-W>h
"nnoremap <silent> <C-L> <C-W>l

" Buffer and Quickfix navigation
"nnoremap <silent> <leader>j :cn<cr>
"nnoremap <silent> <leader>k :cp<cr>
"nnoremap <silent> <leader>l :bn<cr>
"nnoremap <silent> <leader>h :bp<cr>

" Emacs key-binding in vim!
" Since c-a is actually useful, we set it and <c-x> to + and - respectively
cnoremap <c-a> <home>
inoremap <C-a> <C-o>0
inoremap <C-e> <C-o>$
nnoremap <C-e> $
nnoremap <C-a> 0

nnoremap + <c-a>
nnoremap - <c-x>

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
        au VimResized * exe "normal! \<c-w>="
augroup END

" Sets minimum split width
set winwidth=85

" Put visually selected text in the '*' (middleclick/mouse) register and
" '+' (global clipboard) register
set clipboard=unnamed
set clipboard+=autoselect
set clipboard+=unnamedplus

" Map annoying and useless <F1>, Q and K to more useful things
" F1 clears search highlighting and refreshes, Q repeats last macro, K splits
" the line and removes trailing whitespace (reverse of J/gJ)
nnoremap <F1> <nop>
nnoremap Q @@
nnoremap K i<cr><esc>k:let _s=@/<cr>:s/\s\+$//e<cr>:let @/=_s<cr>$
set nojoinspaces
nnoremap L }
nnoremap H {
nnoremap { ^
nnoremap } $

" C/C++ programming maps
nnoremap <leader>m :make<cr>
"nnoremap <leader>v :!valgrind --leak-check=full -v --show-reachable=yes --track-origins=yes ./

" Remove delay after esc + certain commands (e.g. O)
set noesckeys

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
nmap <silent> <Leader>cws :call <SID>StripTrailingWhitespace()<CR>

" Delete buffer while keeping window layout (don't close buffer's windows). {{{
" Version 2008-11-18 from http://vim.wikia.com/wiki/VimTip165
if v:version < 700 || exists('loaded_bclose') || &cp
        finish
endif
let loaded_bclose = 1
if !exists('bclose_multiple')
        let bclose_multiple = 1
endif

" Display an error message.
function! s:Warn(msg)
        echohl ErrorMsg
        echomsg a:msg
        echohl NONE
endfunction

" Command ':Bclose' executes ':bd' to delete buffer in current window.
" The window will show the alternate buffer (Ctrl-^) if it exists,
" or the previous buffer (:bp), or a blank buffer if no previous.
" Command ':Bclose!' is the same, but executes ':bd!' (discard changes).
" An optional argument can specify which buffer to close (name or number).
function! s:Bclose(bang, buffer)
        if empty(a:buffer)
                let btarget = bufnr('%')
        elseif a:buffer =~ '^\d\+$'
                let btarget = bufnr(str2nr(a:buffer))
        else
                let btarget = bufnr(a:buffer)
        endif
        if btarget < 0
                call s:Warn('No matching buffer for '.a:buffer)
                return
        endif
        if empty(a:bang) && getbufvar(btarget, '&modified')
                call s:Warn('No write since last change for buffer '.btarget.' (use :Bclose!)')
                return
        endif
        " Numbers of windows that view target buffer which we will delete.
        let wnums = filter(range(1, winnr('$')), 'winbufnr(v:val) == btarget')
        if !g:bclose_multiple && len(wnums) > 1
                call s:Warn('Buffer is in multiple windows (use ":let bclose_multiple=1")')
                return
        endif
        let wcurrent = winnr()
        for w in wnums
                execute w.'wincmd w'
                let prevbuf = bufnr('#')
                if prevbuf > 0 && buflisted(prevbuf) && prevbuf != w
                        buffer #
                else
                        bprevious
                endif
                if btarget == bufnr('%')
                        " Numbers of listed buffers which are not the target to be deleted.
                        let blisted = filter(range(1, bufnr('$')), 'buflisted(v:val) && v:val != btarget')
                        " Listed, not target, and not displayed.
                        let bhidden = filter(copy(blisted), 'bufwinnr(v:val) < 0')
                        " Take the first buffer, if any (could be more intelligent).
                        let bjump = (bhidden + blisted + [-1])[0]
                        if bjump > 0
                                execute 'buffer '.bjump
                        else
                                execute 'enew'.a:bang
                        endif
                endif
        endfor
        execute 'bdelete'.a:bang.' '.btarget
        execute wcurrent.'wincmd w'
endfunction
command! -bang -complete=buffer -nargs=? Bclose call s:Bclose('<bang>', '<args>')
nnoremap <silent> <Leader>bc :Bclose<CR>
" }}}

" Make :lnext and :lprev wrap around
"nnoremap <Home> :call WrapCommand("up")<CR>
nnoremap <leader>l  :call WrapCommand("down")<CR>

function! WrapCommand(direction)
        if a:direction == "up"
                try
                        lprevious
                catch /^Vim\%((\a\+)\)\=:E553/
                        llast
                endtry
        elseif a:direction == "down"
                try
                        lnext
                catch /^Vim\%((\a\+)\)\=:E553/
                        lfirst
                endtry
        endif
endfunction
