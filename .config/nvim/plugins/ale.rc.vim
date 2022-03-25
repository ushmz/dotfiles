let g:ale_cursor_detail = 1
let g:ale_detail_to_floating_preview = 1
let g:ale_disable_lsp = 1
let g:ale_echo_cursor = 1
let g:ale_fix_on_save = 1
let g:ale_floating_preview = 0
let g:ale_hover_cursor = 0
let g:ale_set_signs = 1
let g:ale_set_highlights = 1

let g:airline#extensions#ale#error_symbol = 0
let g:airline#extensions#ale#warning_symbol = 0
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'css': ['csslint'],
\   'html': ['HTMLHint'],
\   'javascript': ['eslint', 'prettier'],
\   'typescript': ['eslint', 'prettier'],
\   'javascriptreact': ['eslint', 'prettier'],
\   'typescriptreact': ['eslint', 'prettier'],
\   'json': ['jsonlint'],
\   'python': ['flake8', 'black'],
\   'go': ['gofmt', 'goimports', 'golines'],
\}


" ale error navigate
nmap <leader>k <cmd>ALEPreviousWrap<CR>zz
nmap <leader>j <cmd>ALENextWrap<CR>zz

let g:ale_sign_warning = '⚠'
autocmd VimEnter,SourcePost * :highlight ALEErrorSign ctermbg=none ctermfg=red
autocmd VimEnter,SourcePost * :highlight ALEWarningSign ctermbg=none ctermfg=yellow
autocmd VimEnter,SourcePost * :highlight ALEInfoSign ctermbg=none ctermfg=green

autocmd VimEnter,SourcePost * :highlight ALEError cterm=underline ctermfg=none ctermbg=none
autocmd VimEnter,SourcePost * :highlight ALEWarning cterm=underline ctermfg=none ctermbg=none
autocmd VimEnter,SourcePost * :highlight ALEInfo cterm=underline ctermfg=none ctermbg=none
