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

nnoremap <silent> <leader>s :<C-u>split<CR><C-w>w
nnoremap <silent> <leader>v :<C-u>vsplit<CR><C-w>w
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
