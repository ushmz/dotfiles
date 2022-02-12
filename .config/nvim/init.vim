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
" Key binding
"--------------------------------
inoremap <silent> jj <ESC>
" Switch the line with the above line
nnoremap MM ddkkp
" Switch the line with the below line
nnoremap mm ddp
nnoremap ; :
xnoremap ; :
" Emacs key bind in Insert mode
imap <C-p> <Up>
imap <C-n> <Down>
imap <C-b> <Left>
imap <C-f> <Right>
imap <C-a> <C-o>:call <SID>home()<CR>
imap <C-e> <End>
imap <C-d> <Del>
imap <C-h> <BS>

nnoremap <silent><nowait> tt :<C-u>tabnew<cr>
nnoremap g] :tabnext<CR>
nnoremap g[ :tabprevious<CR>

" Auto-close bracket(Use instead of plugin "jiangmiao/auto-pairs")
" inoremap { {}<LEFT>
" inoremap [ []<LEFT>
" inoremap ( ()<LEFT>
" inoremap < <><LEFT>
" inoremap " ""<LEFT>
" inoremap ' ''<LEFT>


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


" -------------------------------
"  autocmd
" -------------------------------
autocmd BufReadPost *.kt setlocal filetype=kotlin
autocmd BufNewFile,BufRead *.jsx set filetype=javascriptreact
autocmd BufNewFile,BufRead *.tsx set filetype=typescriptreact
autocmd BufNewFile,BufRead *.tsx let b:tsx_ext_found = 1
autocmd FileType javascriptreact set tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType typescriptreact set tabstop=2 shiftwidth=2 softtabstop=2

" -------------------------------
"  templates
" -------------------------------
autocmd BufNewFile *.sh 0r $HOME/.vim/templates/skeleton.sh


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

" Complement on command line
" set wildmode=list:longest

" command! MakeTags !crags -R .
" `^[` to jump to tag under the cursor
" `g^]` for ambiguous tags
" `^t` to jump back to thh tag stack


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
set wildmode

" Double ESC to turn off highlight
nmap <Esc><Esc> :nohlsearch<CR><Esc>


"--------------------------------
" Plugins
"--------------------------------
if &compatible
  set nocompatible
endif

let s:dein_dir = expand('~/.cache/dein')

let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" dein configuration
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  let s:toml_dir = expand('~/.config/nvim')

  call dein#load_toml(s:toml_dir . '/dein.toml', {'lazy': 0})

  call dein#load_toml(s:toml_dir . '/dein_lazy.toml', {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable

" dein plugin install check
if dein#check_install()
  call dein#install()
endif

" disable auto recache
let g:dein#auto_recache = 0

" vim-closetag
let g:closetag_filetypes = 'html,javascriptreact,typescriptreact'
let g:closetag_shortcut = '>'
let g:closetag_close_shortcut = '<leader>>'

" vim-resizer
let g:winresizer_vert_resize = 1
let g:winresizer_horiz_resize = 1

" indentLine
" ['¦', '┆', '┊', '|']
let g:indentLine_char_list = ['¦', '┆']
