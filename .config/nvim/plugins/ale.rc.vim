let g:ale_cursor_detail = 1
let g:ale_detail_to_floating_preview = 1
let g:ale_disable_lsp = 1
let g:ale_echo_cursor = 1
let g:ale_fix_on_save = 1
let g:ale_floating_preview = 0
let g:ale_hover_cursor = 0
let g:ale_lint_on_enter = 0
let g:ale_set_signs = 1
let g:ale_set_highlights = 1

" let g:ale_echo_msg_error_str = g:ALEErrorSign
" let g:ale_echo_msg_warning_str = g:ALEWarningSign
" let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'


let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'css': ['csslint'],
\   'html': ['HTMLHint'],
\   'javascript': ['eslint', 'prettier'],
\   'typescript': ['eslint', 'prettier'],
\   'javascriptreact': ['eslint', 'prettier'],
\   'typescriptreact': ['eslint', 'prettier'],
\   'python': ['black'],
\   'go': ['gofmt', 'goimports', 'golines'],
\}

let g:ale_python_flake8_executable = g:python3_host_prog
let g:ale_python_flake8_options = '-m flake8'
let g:ale_python_autopep8_executable = g:python3_host_prog
let g:ale_python_autopep8_options = '-m autopep8'
let g:ale_python_isort_executable = g:python3_host_prog
let g:ale_python_isort_options = '-m isort'
let g:ale_python_black_executable = g:python3_host_prog
let g:ale_python_black_options = '-m black'

" \   'json': ['jsonlint'],

" ale error navigate
nmap <leader>k <cmd>ALEPreviousWrap<CR>zz
nmap <leader>j <cmd>ALENextWrap<CR>zz
nmap <leader>x <cmd>ALEFix<CR>

let g:ale_sign_warning = '⚠'
autocmd VimEnter,SourcePost * :highlight ALEErrorSign ctermbg=none ctermfg=red
autocmd VimEnter,SourcePost * :highlight ALEWarningSign ctermbg=none ctermfg=yellow
autocmd VimEnter,SourcePost * :highlight ALEInfoSign ctermbg=none ctermfg=green

autocmd VimEnter,SourcePost * :highlight ALEError cterm=underline ctermfg=none ctermbg=none
autocmd VimEnter,SourcePost * :highlight ALEWarning cterm=underline ctermfg=none ctermbg=none
autocmd VimEnter,SourcePost * :highlight ALEInfo cterm=underline ctermfg=none ctermbg=none

function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors
    return l:counts.total == 0 ? 'OK' : printf(
        \   '%d g:ALEErrorSign %d g:ALEWarningSign',
        \   all_non_errors,
        \   all_errors
        \)
endfunction
set statusline+=%=
set statusline+=\ %{LinterStatus()}
