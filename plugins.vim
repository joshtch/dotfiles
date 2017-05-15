function! s:has_plugin(name)
    return has_key(g:plugs, a:name)
endfunction

" Airline: custom statusline
if s:has_plugin('vim-airline')
    set lazyredraw
    set t_Co=256
    set ttimeoutlen=50
    set noshowmode
    let g:airline_powerline_fonts = 0
    let g:airline_modified_detection = 1
    let g:airline_left_sep = ''
    let g:airline_left_alt_sep = ''
    let g:airline_right_sep = ''
    let g:airline_right_alt_sep = ''
    if !exists('g:airline_symbols')
        let g:airline_symbols = {}
    endif
    let g:airline_symbols.readonly = ''
    let g:airline_symbols.modified = '+'
    let g:airline_symbols.space = ' '
    let g:airline_symbols.whitespace = '!'
    let g:airline_symbols.branch = ''
    let g:airline_symbols.linenr = ''
    let g:airline_symbols.paste = 'PASTE'
    let g:airline#extensions#fugitive#enabled = 1
    let g:airline#extensions#syntastic#enabled = 1
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#buffer_nr_show = 1
    let g:airline#extensions#tagbar#enabled = 1
    let g:airline#extensions#capslock#enabled = 1
    let g:airline#extensions#hunks#enabled = 1
    let g:airline_section_y = '%{synIDattr(synID(line("."),col("."),1),"name")}'
    if s:has_plugin('vim-airline-themes')
        let g:airline_theme = 'solarized'
    endif
endif

" Capslock: enable capslock from within vim
if s:has_plugin('vim-capslock')
    imap <C-g>u <Plug>CapsLockToggle
endif

" Dispatch:
if s:has_plugin('vim-dispatch')
    nnoremap <leader>m :Dispatch<CR>
endif

" Exchange:
if s:has_plugin('vim-exchange')
    nmap cx <Plug>(Exchange)
    vmap X <Plug>(Exchange)
    nmap cxc <Plug>(ExchangeClear)
    nmap cxx <Plug>(ExchangeLine)
endif

" Focus: Force display of a single buffer for focused editing
if s:has_plugin('focus.vim')
    nmap <silent> <Leader>f <Plug>FocusModeToggle
    let g:focus_use_default_mapping = 0
endif

" Fugitive: Awesome git plugin for vim
if s:has_plugin('vim-fugitive')
    nnoremap <Leader>ga :<C-u>Git add %<CR><CR>
    nnoremap <Leader>gb :<C-u>Gblame<CR>
    nnoremap <Leader>gc :<C-u>Gcommit<CR>
    nnoremap <Leader>gd :<C-u>Gdiff<CR>
    nnoremap <Leader>gl :<C-u>Glog<CR>
    nnoremap <Leader>gp :<C-u>Git push<CR>
    nnoremap <Leader>gs :<C-u>Git status -sb<CR>
endif

" NERDCommenter:
if s:has_plugin('nerdcommenter')
    let NERDMenuMode = 0
endif

" Niceblock:
if s:has_plugin('vim-niceblock')
    vmap I <Plug>(niceblock-I)
    vmap A <Plug>(niceblock-A)
endif

" Open Browser: Open a URL in the default browser
if s:has_plugin('open-browser.vim')
    map gl <Plug>(openbrowser-open)
    map gs <Plug>(openbrowser-search)
    map gb <Plug>(openbrowser-smart-search)
    noremap <Leader>ob :<C-u>OpenBrowserSmartSearch<Space>
endif

" Quick Scope: highlight target characters to use to jump to a word with f/F/t/T
if s:has_plugin('quick-scope')
    let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
endif

" Secure Modelines: fix security of modelines without disabling them altogether
if s:has_plugin('securemodelines')
    set modelines=0
    set secure
endif

" Solarized: colorscheme
if v:version >= 702 && s:has_plugin('vim-colors-solarized')
    syntax enable
    let g:solarized_menu=0
    call togglebg#map("<Leader>5")
    iunmap <Leader>5
    let g:solarized_termtrans=1
    let g:solarized_termcolors=16
    let g:solarized_visibility = "normal"
    let g:solarized_contrast = "normal"
    set background=dark
    colorscheme solarized
endif

" Syntastic: Real-time syntax checking
if s:has_plugin('syntastic')
    let g:syntastic_check_on_open = 1
    let g:syntastic_check_on_wq = 0
    let g:syntastic_auto_loc_list = 0
    let g:syntastic_filetype_map = { 'latex': 'tex' }
    let g:syntastic_stl_format = '[%E{Err: %fe #%e}]'

    " Add shellcheck to the list of syntastic checkers
    let g:syntastic_bash_checkers = ['shellcheck']
    let g:syntastic_dash_checkers = ['shellcheck']
    let g:syntastic_ksh_checkers  = ['shellcheck']
    let g:syntastic_sh_checkers   = ['shellcheck']
    let g:syntastic_zsh_checkers  = ['shellcheck']

    let g:syntastic_list_height = 5
    let g:syntastic_error_symbol = '✗'
    let g:syntastic_warning_symbol = '⚠'
    let g:syntastic_c_check_header = 1
    "let g:syntastic_auto_refresh_includes = 1
endif

" Tmux Settings:
if exists('$TMUX')
    " VimTmuxNavigator: Seamlessly navigate vim and tmux splits
    if s:has_plugin('vim-tmux-navigator')
        let g:tmux_navigator_no_mappings = 1
        nnoremap <silent> <C-h> :<C-u>TmuxNavigateLeft<CR>
        nnoremap <silent> <C-j> :<C-u>TmuxNavigateDown<CR>
        nnoremap <silent> <C-k> :<C-u>TmuxNavigateUp<CR>
        nnoremap <silent> <C-l> :<C-u>TmuxNavigateRight<CR>
        nnoremap <silent> <C--> :<C-u>TmuxNavigatePrevious<CR>
    endif
endif

" Tabular: Character alignment
if s:has_plugin('tabular')
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
    command! AlignSpaces Tab /\s\+\zs/l1r0
endif

" Unite: Unified interface for file, buffer, yankstack, etc. management
if s:has_plugin('unite.vim')
    let g:unite_source_history_yank_enable = 1
    call unite#filters#matcher_default#use(['matcher_fuzzy'])
    nnoremap Ut :<C-u>Unite -no-split -buffer-name=files -start-insert file_rec/async:! -resume<CR>
    nnoremap Uf :<C-u>Unite -no-split -buffer-name=files -start-insert file -resume<CR>
    nnoremap Ur :<C-u>Unite -no-split -buffer-name=mru -start-insert file_mru -resume<CR>
    nnoremap Uo :<C-u>Unite -no-split -buffer-name=outline -start-insert outline -resume<CR>
    nnoremap Uy :<C-u>Unite -no-split -buffer-name=yank history/yank -resume<CR>
    nnoremap Ub :<C-u>Unite -no-split -buffer-name=buffer buffer -resume<CR>
    nnoremap Ug :<C-u>Unite -no-split -buffer-name=outline -start-insert tag -resume<CR>
    call unite#filters#matcher_default#use(['matcher_fuzzy', 'matcher_hide_hidden_files'])
    call unite#filters#sorter_default#use(['sorter_rank'])
    augroup UniteSettings
        autocmd!
        autocmd BufEnter *
                \ if empty(&buftype)
                \| nnoremap <Buffer> <C-]> :<C-u>UniteWithCursorWord -immediately tag<CR>
                \| endif
        autocmd FileType unite nmap <buffer> <Esc> <Plug>(unite_exit)
        autocmd FileType unite call clearmatches()
    augroup END
    " Use ag if available and ignore files in .gitignore/.hgignore
    if executable('ag')
        let g:unite_source_rec_async_command='ag --nocolor --nogroup --hidden -g'
    endif
endif

" Vinegar: netrw improvements
if s:has_plugin('vim-vinegar')
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
            vert res 70
            let t:expl_buf_num = bufnr("%")
        endif
    endfunction
    noremap <silent> <C-e> :<C-u>call ToggleVExplorer()<CR>
endif

" YouCompleteMe:
if s:has_plugin('YouCompleteMe')
    let g:ycm_enable_diagnostic_signs = 0
    let g:ycm_filetype_specific_completion_to_disable = {'scheme': 1 }
endif
