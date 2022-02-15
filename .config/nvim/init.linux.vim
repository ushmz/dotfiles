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


"--------------------------------
" python path setting
"--------------------------------
let g:python3_host_prog = '/home/yusuk/.config/nvim/venv/bin/python'
let g:python_host_prog = '/home/yusuk/.config/nvim/venv/bin/python'

" source setting files
source $HOME/.config/nvim/init.d/mappings.vim
source $HOME/.config/nvim/init.d/settings.vim
source $HOME/.config/nvim/init.d/autocmd.vim
source $HOME/.config/nvim/init.d/plugins.vim

