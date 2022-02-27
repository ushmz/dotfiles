"--------------------------------
" initializeing
"--------------------------------
" init autocmd
autocmd!
" set script encoding
scriptencoding utf-8
" Stop loading vimrc when `tiny` or `small`
if !1 | finish | endif

let mapleader = "\<Space>"

"--------------------------------
" auto reload .vimrc
"--------------------------------
let s:init_dir = expand('$HOME/.config/nvim/init.d')

augroup source_vimrc
  autocmd!
  autocmd BufWritePost init.vim source $MYVIMRC | set foldmethod=marker
  autocmd BufWritePost init_dir/* source $MYVIMRC | set foldmethod=marker
augroup END


"--------------------------------
" python path setting
"--------------------------------
let g:python3_host_prog = '/home/yusuk/.config/nvim/venv/bin/python'
let g:python_host_prog = '/home/yusuk/.config/nvim/venv/bin/python'

" source setting files
exe ('source ' . s:init_dir . '/mappings.vim')
exe ('source ' . s:init_dir . '/settings.vim')
exe ('source ' . s:init_dir . '/autocmd.vim')
exe ('source ' . s:init_dir . '/plugins.vim')

