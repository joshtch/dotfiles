" Ag Vim: Ag plugin for vim
if executable('ag')
    NeoBundle 'rking/ag.vim'
    set grepprg="ag --nogroup --nocolor --column"
    command! -bar -nargs=+ -complete=file Ag silent! grep! <args>|redraw!
else
    let grep_settings  = "grep -rnH --exclude=tags "
    let grep_settings .= "--exclude-dir=.git --exclude-dir=node_modules"
    set grepprg=grep_settings
endif

" Unite: Unified interface for file, buffer, yankstack, etc. management
let g:unite_source_history_yank_enable = 1
call unite#filters#matcher_default#use(['matcher_fuzzy'])
nnoremap Ut :<C-u>Unite -no-split -buffer-name=files -start-insert file_rec/async:! -resume<CR>
nnoremap Uf :<C-u>Unite -no-split -buffer-name=files -start-insert file -resume<CR>
nnoremap Ur :<C-u>Unite -no-split -buffer-name=mru -start-insert file_mru -resume<CR>
nnoremap Uo :<C-u>Unite -no-split -buffer-name=outline -start-insert outline -resume<CR>
nnoremap Uy :<C-u>Unite -no-split -buffer-name=yank history/yank -resume<CR>
nnoremap Ub :<C-u>Unite -no-split -buffer-name=buffer buffer -resume<CR>
nnoremap Ug :<C-u>Unite -no-split -buffer-name=outline -start-insert tag -resume<CR>
nnoremap Uu :<C-u>Unite -log -wrap -vertical -direction=botright neobundle/update<CR>
call unite#filters#matcher_default#use(['matcher_fuzzy', 'matcher_hide_hidden_files'])
call unite#filters#sorter_default#use(['sorter_rank'])

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

" Solarized: colorscheme
if v:version >= 702
    syntax enable
    colorscheme solarized
    set background=light
    call togglebg#map("<Leader>5")
    iunmap <Leader>5
    let g:solarized_termcolors=16
    let g:solarized_termtrans=0
endif

" Capslock: enable capslock from within vim
imap <C-g>u <Plug>CapsLockToggle

" Airline: custom statusline
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
augroup AirlineSymbols
    autocmd!
    autocmd VimEnter * let g:airline_symbols.branch = '⭠'
                \| let g:airline_linecolumn_prefix = '¶'
                \| let g:airline_symbols.readonly = '⭤'
                \| let g:airline_symbols.linenr = '⭡'
                \| let g:airline_symbols.paste = 'PASTE'
augroup END
let g:airline_fugitive_prefix = '⎇ '
let g:airline_theme = 'solarized'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline_section_y = '%{synIDattr(synID(line("."),col("."),1),"name")}'

" Secure Modelines: fix security of 'modelines' without disabling it altogether
set modelines=0
set secure
if exists(':NeoBundleSource')
    NeoBundleSource securemodelines
endif

" Tmux Settings:
if exists('$TMUX')
    " Autolabel tmux windows (currently broken for some reason)
    "augroup Tmux
        "autocmd!
        "autocmd VimEnter,BufNewFile,BufReadPost * call system('tmux rename-window "vim - ' . split(substitute(getcwd(), $HOME, '~', ''), '/')[-1] . '"')
        "autocmd VimLeave * call system('tmux rename-window ' . split(substitute(getcwd(), $HOME, '~', ''), '/')[-1])
    "augroup END

    " Vimux: Interact with a tmux split directly from vim's commandline
    nnoremap <Leader>vs :<C-u>call VimuxRunCommand('exec zsh')<CR>:call VimuxRunCommand('clear')<CR>
    nnoremap <Leader>vc :<C-u>VimuxCloseRunner<CR>
    nnoremap <Leader>vp :<C-u>VimuxPromptCommand<CR>
    nnoremap <Leader>vr :<C-u>VimuxRunLastCommand<CR>

    " VimTmuxNavigator: Seamlessly navigate vim and tmux splits
    let g:tmux_navigator_no_mappings = 1
    nnoremap <silent> <C-h> :<C-u>TmuxNavigateLeft<CR>
    nnoremap <silent> <C-j> :<C-u>TmuxNavigateDown<CR>
    nnoremap <silent> <C-k> :<C-u>TmuxNavigateUp<CR>
    nnoremap <silent> <C-l> :<C-u>TmuxNavigateRight<CR>
    nnoremap <silent> <C--> :<C-u>TmuxNavigatePrevious<CR>
endif

" TeX PDF: LaTeX compiling in Vim. Requires latex-mk or rubber
let g:tex_pdf_map_keys = 0
nnoremap <silent> gc :<C-u>BuildAndViewTexPdf<CR>
nnoremap <silent> gC :<C-u>BuildTexPdf<CR>
" TODO: look into coot/atp_vim for autocompiling + special completions + stuff

" Tabular: Character alignment
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

" Arpeggio: Chord arbitrary keys together (e.g. 'jk' to esc)
if v:version >= 702 && !g:entered_vim
    silent! Arpeggio inoremap jk <Esc>
endif

" Exchange:
nmap cx <Plug>(Exchange)
vmap x <Plug>(Exchange)
nmap cxc <Plug>(ExchangeClear)
nmap cxx <Plug>(ExchangeLine)

" Focus: Force display of a single buffer for focused editing
nmap <silent> <Leader>f <Plug>FocusModeToggle
let g:focus_use_default_mapping = 0

" Better Whitespace: highlight trailing WS on all lines except current
if exists(":StripWhitespace")
    augroup BetterWhitespace
        autocmd!
        autocmd BufWinEnter * execute "EnableWhitespace"
        autocmd FileType unite,markdown execute "DisableWhitespace"
        autocmd BufWinLeave * execute "DisableWhitespace"
    augroup END
    nnoremap <silent> <Leader>cws :StripWhitespace<CR>
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
        let s:_ishls=v:hlsearch
        let s:_lastsearch=@/
        let s:_startline=line(".")
        let s:_startcol=col(".")
        %s/\s\+$//e
        let @/=s:_lastsearch
        let v:hlsearch=s:_ishls
        call cursor(s:_startline, s:_startcol)
        unlet s:_startline s:_startcol s:_lastsearch s:_ishls
    endfunction
    nnoremap <silent> <Leader>cws :call <SID>StripTrailingWhitespace()<CR>
endif

" Syntastic: Real-time syntax checking
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

" YouCompleteMe:
let g:ycm_enable_diagnostic_signs = 0

" Fugitive: Awesome git plugin for vim
nnoremap <Leader>ga :<C-u>Git add %<CR><CR>
nnoremap <Leader>gb :<C-u>Gblame<CR>
nnoremap <Leader>gc :<C-u>Gcommit<CR>
nnoremap <Leader>gd :<C-u>Gdiff<CR>
nnoremap <Leader>gl :<C-u>Glog<CR>
nnoremap <Leader>gp :<C-u>Git push<CR>
nnoremap <Leader>gs :<C-u>Git status -sb<CR>

" Vinegar: netrw improvements
" Still haven't jumped on the NerdTree bandwagon
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

" Open Browser: Open a URL in the default browser
map gl <Plug>(openbrowser-open)
map gs <Plug>(openbrowser-search)
map gb <Plug>(openbrowser-smart-search)
noremap <Leader>ob :<C-u>OpenBrowserSmartSearch<Space>

" YouCompleteMe:
let g:ycm_filetype_specific_completion_to_disable = {'scheme': 1 }

" Dispatch:
nnoremap <leader>m :Dispatch<CR>
