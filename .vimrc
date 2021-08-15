"--------------------------------
" python path setting
"--------------------------------
let g:python3_host_prog = '/Users/ushmz/.config/nvim/pynvim/bin/python'
let g:python_host_prog = '/Users/ushmz/.config/nvim/pynvim/bin/python'


"--------------------------------
" Key binding
"--------------------------------
inoremap <silent> jj <ESC>
nnoremap ; :
xnoremap ; :


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

" vim-closetag
let g:closetag_filetypes = 'html,javascriptreact,typescriptreact'
let g:closetag_shortcut = '>'
let g:closetag_close_shortcut = '<leader>>'

" vim-resizer
let g:winresizer_vert_resize = 1
let g:winresizer_horiz_resize = 1

" indent-guide
" let g:indent_guides_enable_on_vim_startup=1
" let g:indent_guides_guide_size = 1
" let g:indent_guides_start_level = 2


"--------------------------------
" Variables
"--------------------------------
let g:go_disable_autoinstall = 1
let g:vim_json_syntax_conceal = 0
let g:jsx_ext_required = 0
let g:coc_filetype_map = 1


"--------------------------------
" lightline appearance(plugin)
"--------------------------------
let g:lightline = {
      \ 'colorscheme': 'seoul256'
      \ }
let g:lightline = {
        \ 'colorscheme': 'wombat',
        \ 'mode_map': {'c': 'NORMAL'},
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
        \ },
        \ 'component_function': {
        \   'modified': 'LightlineModified',
        \   'readonly': 'LightlineReadonly',
        \   'fugitive': 'LightlineFugitive',
        \   'filename': 'LightlineFilename',
        \   'fileformat': 'LightlineFileformat',
        \   'filetype': 'LightlineFiletype',
        \   'fileencoding': 'LightlineFileencoding',
        \   'mode': 'LightlineMode'
        \ }
        \ }

function! LightlineModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightlineReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
endfunction

function! LightlineFilename()
  return ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

function! LightlineFugitive()
  if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
    return fugitive#head()
  else
    return ''
  endif
endfunction

function! LightlineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightlineFileencoding()
  return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightlineMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction

