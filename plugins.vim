" NeoBundle plugin setup {{{

" Autoinstall NeoBundle
if has('vim_starting')
        set runtimepath+=~/.vim/bundle/neobundle.vim/
        if !isdirectory(expand('~/.vim/bundle/neobundle.vim'))
                !mkdir -p ~/.vim/bundle/neobundle && git clone 'https://github.com/Shougo/neobundle.vim.git'    ~/.vim/bundle/neobundle
        endif
endif

call neobundle#rc(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

" Vimproc: Asynchronous updating
NeoBundle 'Shougo/vimproc', {
    \ 'build' : {
    \       'windows' : 'make -f make_mingw32.mak',
    \       'cygwin' : 'make -f make_cygwin.mak',
    \       'mac' : 'make -f make_mac.mak',
    \       'unix' : 'make -f make_unix.mak'
    \      },
    \ }

" Unite: Unified interface for file, buffer, yankstack, etc. management {{{
NeoBundle 'Shougo/unite.vim', { 'depends' : 'Shougo/vimproc' }
let g:unite_source_history_yank_enable = 1
call unite#filters#matcher_default#use(['matcher_fuzzy'])
nnoremap <leader>ut :Unite -no-split -buffer-name=files -start-insert file_rec/async:! -resume<cr>
nnoremap <leader>uf :Unite -no-split -buffer-name=files -start-insert file -resume<cr>
nnoremap <leader>ur :Unite -no-split -buffer-name=mru -start-insert file_mru -resume<cr>
nnoremap <leader>uo :Unite -no-split -buffer-name=outline -start-insert outline -resume<cr>
nnoremap <leader>uy :Unite -no-split -buffer-name=yank history/yank -resume<cr>
nnoremap <leader>ub :Unite -no-split -buffer-name=buffer buffer -resume<cr>
augroup UniteTags
        autocmd!
        autocmd BufEnter *
                \ if empty(&buftype)
                \| nnoremap <buffer> <C-]> :<C-u>UniteWithCursorWord -immediately tag<cr>
                \| endif
augroup END
" }}}

" Solarized: colorscheme {{{
NeoBundle 'altercation/vim-colors-solarized'
syntax enable
colorscheme solarized
set background=dark
call togglebg#map("<leader>5")
let g:solarized_termcolors=16
let g:solarized_termtrans=0
" }}}

" Vimux: Interact with a tmux split directly from vim's commandline {{{
NeoBundle 'benmills/vimux'
nmap <leader>vs :call VimuxRunCommand('exec zsh')<cr>:call VimuxRunCommand('clear')<cr>
nmap <leader>vc :VimuxCloseRunner<cr>
nmap <leader>vp :VimuxPromptCommand<cr>
nmap <leader>vr :VimuxRunLastCommand<cr>
" }}}

" vim-airline statusline {{{
NeoBundle 'bling/vim-airline'
silent! set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 10
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

" VimTmuxNavigator: Seamlessly navigate vim and tmux splits {{{
NeoBundle 'christoomey/vim-tmux-navigator'
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
nnoremap <silent> <c-l> :TmuxNavigateRight<cr>
nnoremap <silent> <c--> :TmuxNavigatePrevious<cr>
" }}}

" Vim_lint: Syntax checking for vimscript
NeoBundle 'dbakker/vim-lint', { 'depends' : 'scrooloose/syntastic' }

" Tabular: Character alignment {{{
NeoBundle 'godlygeek/tabular'
if exists(":Tabularize")
        nmap <leader>a= :Tabularize /=<cr>
        xmap <leader>a= :Tabularize /=<cr>
        nmap <leader>a: :Tabularize /:\zs<cr>
        xmap <leader>a: :Tabularize /:\zs<cr>
        " Tabular operator function
        " Operations have the form <mapping> <textobject> <alignment char>
        " For example, to align a paragraph along '=' chars, do <leader>tip=
        function! s:tabularize_op(type, ...)
                let c = nr2char(getchar())
                execute "'[,']Tabularize/".c
        endfunction
        nnoremap <silent> <Leader>t :set opfunc=<SID>tabularize_op<Enter>g@
endif
" }}}

" Unite_outline: Outlining in unite
NeoBundle 'h1mesuke/unite-outline', { 'depends' : 'Shougo/unite.vim' }

" Niceblock: Use I and A in all visual modes, not just visual block mode
NeoBundle 'kana/vim-niceblock', { 'neobundle-options-vim_version' : '7.3' }

" Bufkill: Close buffers without closing windows
NeoBundle 'mattdbridges/bufkill.vim'

" Signify: Show VCS diff using sign column
"NeoBundle 'mhinz/vim-signify'

" Focus: Force display of a single buffer for focused editing {{{
" This mapping is included to keep focus.vim from setting its own
silent! nmap <leader>f <Plug>FocusModeToggle
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
nmap <silent> <leader>f <Plug>FocusModeToggle:call CleanEmptyBuffers()<cr>
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
NeoBundle 'scrooloose/nerdcommenter'
" }}}

" Gundo: Undo tree visualization {{{
NeoBundle 'sjl/gundo.vim', {
        \ 'neobundle-options-vim_version' : '7.3',
        \ 'neobundle-options-disabled' : '!has("python")'
        \ }
nmap <leader>g :GundoToggle<cr>
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

" Fugitive: Awesome git plugin for vim
NeoBundle 'tpope/vim-fugitive', { 'augroup' : 'fugitive' }

" Capslock: Enable capslock for only insert mode using <C-G>c
NeoBundle 'tpope/vim-capslock'

" Repeat: Enable use of dot operator with certain plugins
NeoBundle 'tpope/vim-repeat'

" RSI: Readline key bindings for insert and command line modes
NeoBundle 'tpope/vim-rsi'

" Surround: Surround text easily
NeoBundle 'tpope/vim-surround'

" Tag: Tag navigation in unite
NeoBundle 'tsukkee/unite-tag', { 'depends' : 'Shougo/unite.vim' }

" Open Browser: Open a URL in the default browser {{{
NeoBundle 'tyru/open-browser.vim', {
        \ 'mappings' : '<Plug>(openbrowser-open),<Plug>(openbrowser-smart-search)'
        \ }
map gu <Plug>(openbrowser-open)
map gs <Plug>(openbrowser-search)
map go <Plug>(openbrowser-smart-search)
nmap <leader>ob :OpenBrowserSmartSearch<space>
" }}}

" UndoCloseWin: Undo closing of tabs and windows {{{
NeoBundle 'tyru/undoclosewin.vim', {
        \ 'mappings' : '<Plug>(ucw-restore-window)'
        \ }
map <leader>br <Plug>(ucw-restore-window)
" }}}


" YouCompleteMe: Smart autocompletion {{{
NeoBundle 'Valloric/YouCompleteMe', {
        \ 'neobundle-options-disabled' : '!has("python") || !has("unix")',
        \ 'neobundle-options-vim_version' : '7.3.584',
        \ 'build' : {
        \       'unix' : '~/.vim/bundle/YouCompleteMe/install.sh',
        \       'mac' : '~/.vim/bundle/YouCompleteMe/install.sh',
        \     }
        \ }
let g:ycm_confirm_extra_conf = 0
let g:ycm_key_detailed_diagnostics = ''
let g:ycm_register_as_syntastic_checker = 1
" }}}

" Holylight: (OSX only) Autoswap between light and dark colorscheme based on {{{
" ambient light level
NeoBundle 'Dinduks/vim-holylight', {
        \ 'neobundle-options-disabled' :
        \       '!has("unix") || system("uname") != "Darwin\n"'
        \ }
" }}}

" Custom Textobjects: {{{
NeoBundle 'kana/vim-textobj-user', { 'neobundle-options-vim_version' : '7.0' }

" Column: textobject ('ii', 'ai', 'iI', and 'aI')
" i vs a: empty lines (not included/included)
" i vs I: more indents (included/not included)
NeoBundle 'kana/vim-textobj-indent'

" Full Buffer: textobject ('ie' and 'ae')
NeoBundle 'kana/vim-textobj-entire', {
        \ 'neobundle-options-vim_version' : '7.2',
        \ 'depends' : 'kana/vim-textobj-user'
        \ }

" Indentation: textobject ('io' and 'ao')
NeoBundle 'michaeljsmith/vim-indent-object', {
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


