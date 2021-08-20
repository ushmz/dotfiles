"--------------------------------
" Key binding
"--------------------------------
inoremap <silent> jj <ESC>
nnoremap ; :
xnoremap ; :
" Emacs key bind in Insert mode
imap <C-p> <Up>
imap <C-n> <Down>
imap <C-b> <Left>
imap <C-f> <Right>
" imap <C-a> <C-o>:call <SID>home()<CR>
" imap <C-e> <End>
imap <C-d> <Del>
imap <C-h> <BS>


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
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=237
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=239
autocmd BufNewFile,BufRead *.jsx set filetype=javascriptreact
autocmd BufNewFile,BufRead *.tsx set filetype=typescriptreact
autocmd BufNewFile,BufRead *.tsx set tabstop=2
autocmd BufNewFile,BufRead *.tsx set shiftwidth=2
autocmd BufNewFile,BufRead *.tsx let b:tsx_ext_found = 1
autocmd BufNewFile,BufRead *.tsx let g:indent_guides_enable_on_vim_startup=1
autocmd BufNewFile,BufRead *.tsx let g:indent_guides_guide_size = 1
autocmd BufNewFile,BufRead *.tsx let g:indent_guides_start_level = 2

"--------------------------------
" Edit
"--------------------------------

" Show matched bracket pair set showmatch

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
" set wildmode

" Double ESC to turn off highlight
nmap <Esc><Esc> :nohlsearch<CR><Esc>

