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
" auto reload .vimrc
"--------------------------------
let s:init_dir = expand('$HOME/.config/nvim/init.d')

augroup source_vimrc
  autocmd!
  autocmd BufWritePost init.vim source $MYVIMRC | set foldmethod=marker
augroup END

" source setting files
exe ('source '. s:init_dir . '/mappings.vim')
exe ('source '. s:init_dir . '/settings.vim')
exe ('source '. s:init_dir . '/autocmd.vim')

