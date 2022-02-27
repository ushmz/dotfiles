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
  " can use `execute` with `autocmd`?
  " execute ('autocmd ' . 'BufWritePost ' . s:init_dir . '/* ' . 'source ' . '$MYVIMRC ' . '| set ' . 'foldmethod=marker')
augroup END

" source setting files
execute ('source '. s:init_dir . '/mappings.vim')
execute ('source '. s:init_dir . '/settings.vim')
execute ('source '. s:init_dir . '/autocmd.vim')
execute ('source '. s:init_dir . '/plugins.vim')

