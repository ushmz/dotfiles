"--------------------------------
" initializeing
"--------------------------------
" init autocmd
autocmd!
" set script encoding
scriptencoding utf-8
" Stop loading vimrc when `tiny` or `small`
if !1 | finish | endif

"--------------------------------
" Excutables path
"--------------------------------
let g:python3_host_prog = $XDG_CONFIG_HOME . '/nvim/pynvim/bin/python'
" let g:python3_host_prog = system('echo -n $(which python)')

"--------------------------------
" auto reload .vimrc
"--------------------------------
let s:init_dir = $XDG_CONFIG_HOME . '/nvim/init.d'

augroup source_vimrc
  autocmd!
  autocmd BufWritePost init.vim source $MYVIMRC | set foldmethod=marker
  " can use `execute` with `autocmd`?
  " execute ('autocmd ' . 'BufWritePost ' . s:init_dir . '/* ' . 'source ' . '$MYVIMRC ' . '| set ' . 'foldmethod=marker')
augroup END

" source setting files
execute ('source '. s:init_dir . '/mappings.vim')
execute ('source '. s:init_dir . '/options.vim')
execute ('source '. s:init_dir . '/plugins.vim')
execute ('source '. s:init_dir . '/autocmd.vim')
