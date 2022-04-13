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
" python path setting
"--------------------------------
" let g:python3_host_prog = $XDG_CONFIG_HOME . '/nvim/venv/bin/python'
" let g:python_host_prog = $XDG_CONFIG_HOME . '/nvim/venv/bin/python'

"--------------------------------
" auto reload .vimrc
"--------------------------------
let s:init_dir = $XDG_CONFIG_HOME . '/nvim/init.d'

augroup source_vimrc
  autocmd!
  autocmd BufWritePost init.vim source $MYVIMRC | set foldmethod=marker
  autocmd BufWritePost init_dir/* source $MYVIMRC | set foldmethod=marker
augroup END

" source setting files
execute ('source ' . s:init_dir . '/mappings.vim')
execute ('source ' . s:init_dir . '/settings.vim')
execute ('source ' . s:init_dir . '/autocmd.vim')
execute ('source ' . s:init_dir . '/plugins.vim')


syntax on
set background=dark
" autocmd VimEnter * nested colorscheme hybrid
" colorscheme hybrid
let g:hybrid_use_term_colors = 1
let g:hybrid_reduced_contrast = 1
