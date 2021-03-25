set number

set background=dark
let g:hybrid_use_term_colors = 1
let g:hybrid_reduced_contrast = 1
colorscheme hybrid
syntax on

hi LineNr ctermbg=0 ctermfg=7
hi CursorLineNr ctermbg=4 ctermfg=0
set cursorline
hi clear CursorLine

inoremap <silent> jj <ESC>

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

if dein#check_install()
  call dein#install()
endif

let g:go_disable_autoinstall = 1
let g:vim_json_syntax_conceal = 0
let g:jsx_ext_required = 0
let g:coc_filetype_map = 1

autocmd BufNewFile,BufRead *.tsx let b:tsx_ext_found = 1
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescriptreact


