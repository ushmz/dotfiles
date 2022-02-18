" basic
inoremap <silent> jj <ESC>
nnoremap ; :
xnoremap ; :

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

nnoremap <silent><nowait> tt :<C-u>tabnew<cr>
nnoremap g] :tabnext<CR>
nnoremap g[ :tabprevious<CR>

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
nmap <Esc><Esc> :nohlsearch<CR><Esc>

" Auto-close bracket(Use instead of plugin "jiangmiao/auto-pairs")
" inoremap { {}<LEFT>
" inoremap [ []<LEFT>
" inoremap ( ()<LEFT>
" inoremap < <><LEFT>
" inoremap " ""<LEFT>
" inoremap ' ''<LEFT>

