"--------------------------------
" Appearance
"--------------------------------
set number
set ruler

" tab & indent
set tabstop=4
set shiftwidth=4
set textwidth=0
set expandtab
set autoindent

" disable screen bell
set novisualbell

" color scheme
syntax on
set background=dark
colorscheme hybrid
let g:hybrid_use_term_colors = 1
let g:hybrid_reduced_contrast = 1

" cursor
hi LineNr ctermbg=0 ctermfg=7
hi CursorLineNr ctermbg=4 ctermfg=0
set cursorline

filetype plugin indent on


"--------------------------------
" Edit
"--------------------------------

" Show matched bracket pair
set showmatch

" Add bracket pair '<' and '>'
set matchpairs& matchpairs+=<:>

" Stop auto back up
set nobackup
set nowritebackup

" Stop swap file
set noswapfile

" Re-read when editting file is changed
set autoread

" Persist "undo"
set undofile
set undodir=~/.vim/undo

" Complement on command line
" set wildmode=list:longest


"--------------------------------
" Search
"--------------------------------

" Search regardless of upper/lower case if query is lowercase only
set ignorecase

" Distinguish with upper/lower case if query contains uppercase
set smartcase

" Increment search
set incsearch

" Fuzzy File Find
" Search down into sub directory
set path+=**

" Display all matching file when tab complete
set wildmode=longest,full


"--------------------------------
" Snippets
"--------------------------------

" vp doesn't replace paste buffer
function! RestoreRegister()
  let @" = s:restore_reg
  return ''
endfunction

function! s:Repl()
  let s:restore_reg = @"
  return "p@=RestoreRegister()\<cr>"
endfunction

vmap <silent> <expr> p <sid>Repl()

" find and replace
vnoremap <silent> s //e<C-r>=&selection=='exclusive'?'+1':''<CR><CR>
    \:<C-u>call histdel('search',-1)<Bar>let @/=histget('search',-1)<CR>gv
omap s :normal vs<CR>

