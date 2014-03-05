" vimrc
" vim:set ft=vim tw=80 sw=4 et

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
        !mkdir -p ~/.vim/bundle/neobundle &&
                \ git clone 'https://github.com/Shougo/neobundle.vim.git'
                \ ~/.vim/bundle/neobundle
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
NeoBundleLazy 'Shougo/unite.vim', { 'depends' : 'Shougo/vimproc',
            \ 'autoload' : { 'commands' : 'Unite' } }
let g:unite_source_history_yank_enable = 1
call unite#filters#matcher_default#use(['matcher_fuzzy'])
nnoremap <Leader>ut :<C-u>Unite -no-split -buffer-name=files -start-insert file_rec/async:! -resume<CR>
nnoremap <Leader>uf :<C-u>Unite -no-split -buffer-name=files -start-insert file -resume<CR>
nnoremap <Leader>ur :<C-u>Unite -no-split -buffer-name=mru -start-insert file_mru -resume<CR>
"nnoremap <Leader>uo :<C-u>Unite -no-split -buffer-name=outline -start-insert outline -resume<CR>
nnoremap <Leader>uy :<C-u>Unite -no-split -buffer-name=yank history/yank -resume<CR>
nnoremap <Leader>ub :<C-u>Unite -no-split -buffer-name=buffer buffer -resume<CR>
nnoremap <Leader>ug :<C-u>Unite -no-split -buffer-name=outline -start-insert tag -resume<CR>
augroup UniteTags
    autocmd!
    autocmd BufEnter *
            \ if empty(&buftype)
            \| nnoremap <Buffer> <C-]> :<C-u>UniteWithCursorWord -immediately tag<CR>
            \| endif
    autocmd FileType unite nmap <buffer> <Esc> <Plug>(unite_exit)
augroup END
" Use ag if available and ignore files in .gitignore/.hgignore
if executable('ag')
    let g:unite_source_rec_async_command='ag --nocolor --nogroup --hidden -g'
endif
nnoremap <Leader>nu :<C-u>Unite -log -wrap -vertical neobundle/update<CR>
" }}}

" Solarized: colorscheme {{{
if v:version >= 702
    NeoBundle 'altercation/vim-colors-solarized', { 'vim_version' : '7.2' }
    syntax enable
    colorscheme solarized
    call togglebg#map("<Leader>5")
    iunmap <Leader>5
    let g:solarized_termcolors=16
    let g:solarized_termtrans=0
endif
" }}}

" Airline: custom statusline {{{
NeoBundle 'bling/vim-airline'
if exists(":AirlineTheme")
    set lazyredraw
    set t_Co=256
    set ttimeoutlen=50
    set noshowmode
    let g:airline_powerline_fonts = 0
    let g:airline_enable_synastic = 1
    let g:airline_enable_fugitive = 1
    let g:airline_modified_detection = 1
    let g:airline_left_sep = '⮀'
    let g:airline_right_sep = '⮂'
    let g:airline_left_alt_sep = '⮁'
    let g:airline_right_alt_sep = '⮃'
    let g:airline_symbols.branch = '⭠'
    let g:airline_linecolumn_prefix = '¶'
    let g:airline_symbols.readonly = '⭤'
    let g:airline_symbols.linenr = '⭡'
    let g:airline_symbols.paste = 'PASTE'
    let g:airline_fugitive_prefix = '⎇ '
    let g:airline_theme = 'solarized'
    let g:airline#extensions#tabline#enabled = 1
endif
" }}}

" Secure Modelines: fix security of 'modelines' without disabling it altogether
NeoBundle 'ciaranm/securemodelines'
set modelines=0
set secure

" Tmux Settings: {{{
if executable('tmux')
    " Autolabel tmux windows
    augroup Tmux
        autocmd!
        autocmd VimEnter,BufNewFile,BufReadPost * call system('tmux rename-window "vim - ' . split(substitute(getcwd(), $HOME, '~', ''), '/')[-1] . '"')
        autocmd VimLeave * call system('tmux rename-window ' . split(substitute(getcwd(), $HOME, '~', ''), '/')[-1])
    augroup END

    " Vimux: Interact with a tmux split directly from vim's commandline {{{
    NeoBundle 'benmills/vimux'
    nnoremap <Leader>vs :<C-u>call VimuxRunCommand('exec zsh')<CR>:call VimuxRunCommand('clear')<CR>
    nnoremap <Leader>vc :<C-u>VimuxCloseRunner<CR>
    nnoremap <Leader>vp :<C-u>VimuxPromptCommand<CR>
    nnoremap <Leader>vr :<C-u>VimuxRunLastCommand<CR>
    " }}}

    " VimTmuxNavigator: Seamlessly navigate vim and tmux splits {{{
    NeoBundle 'christoomey/vim-tmux-navigator'
    let g:tmux_navigator_no_mappings = 1
    nnoremap <silent> <C-h> :<C-u>TmuxNavigateLeft<CR>
    nnoremap <silent> <C-j> :<C-u>TmuxNavigateDown<CR>
    nnoremap <silent> <C-k> :<C-u>TmuxNavigateUp<CR>
    nnoremap <silent> <C-l> :<C-u>TmuxNavigateRight<CR>
    nnoremap <silent> <C--> :<C-u>TmuxNavigatePrevious<CR>
    " }}}
endif
" }}}

" Vim Lint: Syntax checking for vimscript
NeoBundleLazy 'dbakker/vim-lint', { 'autoload' : { 'filetypes' : 'vim' },
            \ 'depends' : 'scrooloose/syntastic' }

" TeX PDF: LaTeX compiling in Vim. Requires latex-mk or rubber {{{
NeoBundleLazy 'vim-scripts/TeX-PDF', { 'autoload' : { 'filetypes' : 'tex' }}
let g:tex_pdf_map_keys = 0
nnoremap <silent> gc :<C-u>BuildAndViewTexPdf<CR>
nnoremap <silent> gC :<C-u>BuildTexPdf<CR>
" TODO: look into coot/atp_vim for autocompiling + special completions + stuff
" }}}

" Tabular: Character alignment {{{
NeoBundleLazy 'godlygeek/tabular', { 'autoload' : { 'commands' : 'Tabularize' }}
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

" Vim Snippets: Default snippets for various languages
NeoBundle 'honza/vim-snippets', { 'disabled' : 1 }
NeoBundle 'MarcWeber/ultisnips', { 'disabled' : 1 }

" Arpeggio: Chord arbitrary keys together (e.g. 'jk' to esc) {{{
if v:version >= 702
    NeoBundle 'kana/vim-arpeggio', { 'vim_version' : '7.2' }
    augroup Arpeggio
        autocmd!
        autocmd VimEnter * Arpeggio inoremap jk <Esc>
    augroup END
endif
" }}}

" Niceblock: Use I and A in all visual modes, not just visual block mode
if v:version >= 703
    NeoBundle 'kana/vim-niceblock', { 'vim_version' : '7.3' }
endif


" Easymotion: Quick navigation {{{
NeoBundle 'Lokaltog/vim-easymotion'

nmap <Space> <Plug>(easymotion-s2)
xmap <Space> <Plug>(easymotion-s2)
omap <Space> <Plug>(easymotion-s2)
let g:EasyMotion_keys = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

hi link EasyMotionShade Comment
hi link EasyMotionTarget2First Question
hi link EasyMotionTarget2Second Question

let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1                      " type `a` and match `a`&`A`
let g:EasyMotion_use_smartsign_us = 1   " Smartsign (type `1` and match `1`&`!`)
let g:EasyMotion_use_upper = 1                     " Use uppercase target labels
let g:EasyMotion_space_jump_first = 1       " Type space and jump to first match
" }}}

" Tagbar: Exuberant-ctags, in a window {{{
NeoBundleLazy 'majutsushi/tagbar', { 'autoload' : { 'filetypes' :
            \ [ 'Ant', 'Assembler', 'ASP', 'Awk', 'Basic', 'BETA', 'C', 'C++',
            \ 'C#', 'COBOL', 'DosBatch', 'Eiffel', 'Erlang', 'Flex', 'Fortran',
            \ 'HTML', 'Java', 'JavaScript', 'Lisp', 'Lua', 'Make', 'MatLab',
            \ 'OCaml', 'Pascal', 'Perl', 'PHP', 'Python', 'REXX', 'Ruby',
            \ 'Scheme', 'Shell ''script', 'SLang', 'SML', 'SQL', 'Tcl', 'Tex',
            \ 'Vera', 'Verilog', 'VHDL', 'Vim', 'YACC'] } }
" }}}

" Bufkill: Close buffers without closing windows
NeoBundleLazy 'vim-scripts/bufkill.vim', { 'autoload' : {
            \ 'commands' : [ 'BD', 'BUN', 'BW', 'BB', 'BF' ] } }

" Signify: Show VCS diff using sign column
NeoBundle 'mhinz/vim-signify'

" Focus: Force display of a single buffer for focused editing {{{
NeoBundleLazy 'merlinrebrovic/focus.vim', { 'autoload' : { 'mappings' :
            \ '<Plug>FocusModeToggle' } }
function! ToggleFocusMode()
    if !exists("t:focusmode")
        autocmd! Resize
    endif
    execute "normal \<Plug>FocusModeToggle"
    if !exists("t:focusmode")
        call AutoResize()
    endif
endfunction
nmap <silent> <Leader>f :<C-u>call ToggleFocusMode()<CR>
let g:focus_use_default_mapping = 0
" }}}

" Better Whitespace: highlight trailing WS on all lines except current {{{
NeoBundle 'ntpeters/vim-better-whitespace'
if exists(":StripWhitespace")
    augroup BetterWhitespace
        autocmd!
        autocmd BufWinEnter * execute "EnableWhitespace"
        autocmd FileType unite,markdown execute "DisableWhitespace"
        autocmd BufWinLeave * execute "DisableWhitespace"
    augroup END
    nnoremap <Leader>cws :StripWhitespace<CR>
else
    augroup AnnoyingWhitespace
        autocmd!
        highlight default link ExtraWhitespace ErrorMsg
        match ExtraWhitespace /\s\+$/
        autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
        autocmd InsertEnter * match ExtraWhitespace /\v\s+%#@<!$/
        autocmd InsertLeave * match ExtraWhitespace /\s\+$/
        autocmd BufWinLeave * call clearmatches()
        autocmd InsertEnter *
                    \ syn clear EOLWS | syn match EOLWS excludenl /\v\s+%#@!$/
        autocmd InsertLeave *
                    \ syn clear EOLWS | syn match EOLWS excludenl /\s\+$/
        highlight default link EOLWS ErrorMsg
    augroup END
    function! <SID>StripTrailingWhitespace()
        " Preparation: save last search, and cursor position.
        let g:_ishls = v:hlsearch
        let g:_lastsearch=@/
        let g:_startline = line(".")
        let g:_startcol = col(".")
        %s/\s\+$//e
        let @/=g:_lastsearch
        let v:hlsearch = g:_ishls
        call cursor(g:_lastline, g:_lastcol)
        unlet g:_lastline g:_lastcol g:_lastsearch g:_ishls
    endfunction
    nnoremap <silent> <Leader>cws :call <SID>StripTrailingWhitespace()<CR>
endif

" Ag Vim: Ag plugin for vim {{{
if executable('ag')
    NeoBundle 'rking/ag.vim'
    set grepprg="ag --nogroup --nocolor --column"
    command! -bar -nargs=+ -complete=file Ag silent! grep! <args>|redraw!
else
    let grep_settings  = "grep -rnH --exclude=tags "
    let grep_settings .= "--exclude-dir=.git --exclude-dir=node_modules"
    set grepprg=grep_settings
endif
" }}}

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
NeoBundle 'scrooloose/nerdcommenter' ", { 'autoload' : {
            "\ 'mappings' : [
            "\        '<Plug>NERDCommenterComment',
            "\        '<Plug>NERDCommenterNested',
            "\        '<Plug>NERDCommenterToggle',
            "\        '<Plug>NERDCommenterMinimal',
            "\        '<Plug>NERDCommenterInvert',
            "\        '<Plug>NERDCommenterSexy',
            "\        '<Plug>NERDCommenterYank',
            "\        '<Plug>NERDCommenterToEOL',
            "\        '<Plug>NERDCommenterAppend',
            "\        '<Plug>NERDCommenterInsert',
            "\        '<Plug>NERDCommenterAlignLeft',
            "\        '<Plug>NERDCommenterAlignBoth',
            "\        '<Plug>NERDCommenterUncomment',
            "\     ]
            "\   }
            "\ }
" }}}

" Capslock: Enable capslock for only insert mode using <C-g>c
NeoBundleLazy 'tpope/vim-capslock',
            \ { 'autoload' : { 'mappings' : '<Plug>CapslockToggle' } }

" Dispatch: Asyncronous compiling with tmux/screen/iterm
NeoBundleLazy 'tpope/vim-dispatch', { 'autoload' : { 'commands' : [ 'Make',
            \ 'Make!', 'Copen', 'Copen!', 'Dispatch', 'Dispatch!',
            \ 'FocusDispatch', 'FocusDispatch!', 'Start', 'Start!' ] } }

" Fugitive: Awesome git plugin for vim {{{
NeoBundle 'tpope/vim-fugitive', { 'augroup' : 'fugitive' }
nnoremap <Leader>ga :<C-u>Git add %<CR>
nnoremap <Leader>gb :<C-u>Gblame<CR>
nnoremap <Leader>gc :<C-u>Gcommit<CR>
nnoremap <Leader>gd :<C-u>Gdiff<CR>
nnoremap <Leader>gl :<C-u>Glog<CR>
nnoremap <Leader>gp :<C-u>Git push<CR>
nnoremap <Leader>gs :<C-u>Git status -sb<CR>
" }}}

" Repeat: Enable use of dot operator with certain plugins
NeoBundle 'tpope/vim-repeat'

" RSI: Readline key bindings for insert and command line modes
NeoBundle 'tpope/vim-rsi'

" Surround: Surround text easily {{{
NeoBundle 'tpope/vim-surround', { 'autoload' : { 'mappings' : [
            \ '<Plug>Dsurround',
            \ '<Plug>Csurround',
            \ '<Plug>Ysurround',
            \ '<Plug>YSurround',
            \ '<Plug>Yssurround',
            \ '<Plug>YSsurround',
            \ '<Plug>YSsurround',
            \ '<Plug>VSurround',
            \ '<Plug>VgSurround',
            \ '<Plug>Isurround',
            \ '<Plug>ISurround', ]}}
" }}}

" Vinegar: netrw improvements {{{
" Still haven't jumped on the NerdTree bandwagon
NeoBundleLazy 'tpope/vim-vinegar', { 'autoload' : { 'filetypes' : 'netrw' } }
function! ToggleVExplorer()
    if exists("t:expl_buf_num")
        normal! <C-w>=
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
noremap <silent> <C-e> :<C-u>call ToggleVExplorer()<CR>
" }}}

" Easydir: Automatically create filepaths for :w, :e, etc if they don't exist
NeoBundle 'dockyard/vim-easydir'

" Tag: Tag navigation in unite
NeoBundle 'tsukkee/unite-tag', { 'depends' : 'Shougo/unite.vim' }

" Open Browser: Open a URL in the default browser {{{
NeoBundleLazy 'tyru/open-browser.vim', {
            \ 'autoload' : {
            \         'mappings' : [
            \                 '<Plug>(openbrowser-open)',
            \                 '<Plug>(openbrowser-search)',
            \                 '<Plug>(openbrowser-smart-search)' ],
            \         'commands' : 'OpenBrowserSmartSearch'
            \      }
            \ }
map gu <Plug>(openbrowser-open)
map gs <Plug>(openbrowser-search)
map go <Plug>(openbrowser-smart-search)
noremap <Leader>ob :<C-u>OpenBrowserSmartSearch<Space>
" }}}

" UndoCloseWin: Undo closing of tabs and windows {{{
NeoBundleLazy 'tyru/undoclosewin.vim', { 'autoload' : {
            \ 'mappings' : '<Plug>(ucw-restore-window)' }
            \ }
map <Leader>br <Plug>(ucw-restore-window)
" }}}

" YouCompleteMe: Smart autocompletion {{{
"if has("python") && has("unix") && v:version >= 703.584
    "NeoBundle 'Valloric/YouCompleteMe', {
            "\ 'vim_version' : '7.3.584',
            "\ 'disabled' : 1,
            "\ 'build' : {
            "\       'unix' : '~/.vim/bundle/YouCompleteMe/install.sh --clang-completer',
            "\       'mac' : '~/.vim/bundle/YouCompleteMe/install.sh',
            "\     }
            "\ }
    "let g:ycm_confirm_extra_conf = 0
    "let g:ycm_use_ultisnips_completer = 1
    "let g:ycm_key_detailed_diagnostics = ''
    "let g:ycm_register_as_syntastic_checker = 1
"endif
" }}}

" Custom Textobjects: {{{
NeoBundle 'kana/vim-textobj-user'

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

" Signify Hunk: textobject ('ih'/'ah') for signify's VCS diffs
NeoBundle 'killphi/vim-textobj-signify-hunk', {
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

" Open help in a vertical split instead of the default horizontal split
" " http://vim.wikia.com/wiki/Replace_a_builtin_command_using_cabbrev
cabbrev h <C-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'vert h' : 'h')<CR>
cabbrev help <C-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'vert h' : 'help')<CR>

" Allow quitting unnamed buffers without confirmation or ! {{{
nnoremap <silent> <Leader>q :<C-u>call QuitIfEmpty()<CR>:q<CR>
function! QuitIfEmpty()
    if empty(bufname('%'))
        setlocal nomodified
    endif
endfunction
" }}}

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
"set matchpairs+=<:> " Match angle brackets with '%'

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

" Use 'verymagic' when searching. Does not verymagic substitutions; if you
" want to verymagic your substitutions, add the flag yourself, or use the
" last search register
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
" inconvenient. Not sure what to do with the default H and L though
noremap L }
noremap H {
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
