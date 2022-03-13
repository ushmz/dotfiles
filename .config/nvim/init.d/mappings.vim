nmap <space> <leader>

" basic
inoremap <silent> jj <ESC>
nnoremap ; :
xnoremap ; :

nnoremap <leader>w :<C-u>w<CR>
nnoremap <leader>q :<C-u>q<CR>

"auto-center on movement commands
nmap G Gzz
nmap n nzz
nmap N Nzz
nmap } }zz
nmap { {zz
nmap <C-d> <C-d>zz
nmap <C-u> <C-u>zz

" Switch the line with the above line
" nnoremap MM ddkkp
" Switch the line with the below line
nnoremap mm ddp

nnoremap <silent> <leader>s :<C-u>split<CR>
nnoremap <silent> <leader>v :<C-u>vsplit<CR>
nnoremap <silent> <leader>t :<C-u>tabnew<cr>
nnoremap <silent> g] :<C-u>tabnext<CR>
nnoremap <silent> g[ :<C-u>tabprevious<CR>

" Emacs key bind in Insert mode
imap <C-p> <Up>
imap <C-n> <Down>
imap <C-b> <Left>
imap <C-f> <Right>
imap <C-a> <C-o>:call <SID>home()<CR>
imap <C-e> <End>
imap <C-d> <Del>
imap <C-h> <BS>

" Double ESC to turn off highlight
nmap <silent> <Esc><Esc> :<C-u>nohlsearch<CR><Esc>

" Auto-close bracket(Use instead of plugin "jiangmiao/auto-pairs")
" inoremap { {}<LEFT>
" inoremap [ []<LEFT>
" inoremap ( ()<LEFT>
" inoremap < <><LEFT>
" inoremap " ""<LEFT>
" inoremap ' ''<LEFT>

" ale error navigate
" nmap <silent> <leader>k <Plug>(ale_previous_wrap)
" nmap <silent> <leader>j <Plug>(ale_next_wrap)

