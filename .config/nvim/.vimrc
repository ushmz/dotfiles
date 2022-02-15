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
augroup source_vimrc
  autocmd!
  autocmd BufWritePost init.vim source $MYVIMRC | set foldmethod=marker
augroup END

" source setting files
source $HOME/.config/nvim/init.d/autocmd.vim
source $HOME/.config/nvim/init.d/mappings.vim
source $HOME/.config/nvim/init.d/settings.vim
