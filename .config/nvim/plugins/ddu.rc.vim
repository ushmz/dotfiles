call ddu#custom#patch_global({
    \ 'ui': 'ff',
    \ 'sources': [{'name': 'file_rec', 'params': {}}],
    \ 'sourceOptions': {
    \   '_': {
    \     'matchers': ['matcher_substring'],
    \   },
    \ },
    \ 'uiParams': {
    \   'ff': {
    \       'split': 'floating',
    \       'startFilter': v:true,
    \   },
    \ },
    \ 'kindOptions': {
    \   'file': {
    \     'defaultAction': 'open',
    \   },
    \ }
    \ })

autocmd FileType ddu-ff call s:ddu_my_settings()
function! s:ddu_my_settings() abort
  nnoremap <buffer><silent> <CR>
        \ <Cmd>call ddu#ui#ff#do_action('itemAction')<CR>
  nnoremap <buffer><silent> <Space>
        \ <Cmd>call ddu#ui#ff#do_action('toggleSelectItem')<CR>
  nnoremap <buffer><silent> i
        \ <Cmd>call ddu#ui#ff#do_action('openFilterWindow')<CR>
  nnoremap <buffer><silent> q
        \ <Cmd>call ddu#ui#ff#do_action('quit')<CR>
endfunction

autocmd FileType ddu-ff-filter call s:ddu_filter_my_settings()
function! s:ddu_filter_my_settings() abort
  inoremap <buffer><silent> <CR>
  \ <Esc><Cmd>close<CR>
  nnoremap <buffer><silent> <CR>
  \ <Cmd>close<CR>
  nnoremap <buffer><silent> q
  \ <Cmd>close<CR>
endfunction

nnoremap <SID>[ug] <Nop>
nmap ;d <SID>[ug]

nnoremap <silent> <SID>[ug]m
    \ <CMD>call ddu#start({'name': 'mr'})<CR>
nnoremap <silent> <SID>[ug]b
    \ <CMD>call ddu#start({'name': 'buffer'})<CR>
nnoremap <silent> <SID>[ug]r
    \ <CMD>call ddu#start({'name': 'register'})<CR>
nnoremap <silent> <SID>[ug]f
    \ <CMD>call ddu#start({'name': 'file'})<CR>
" nnoremap <silent> <SID>[ug]n :<C-u>Ddu file -source-param-new -volatile<CR>
"     \ <CMD>call ddu#start({'name': 'file'})<CR>
