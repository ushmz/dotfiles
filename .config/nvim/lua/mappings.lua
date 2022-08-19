vim.g.mapleader=" "

local key = vim.keymap

-- key.set('n', '<space>', '<leader>', {noremap=true})
key.set('i', 'jj', '<ESC>', {noremap=true, silent=true})
key.set({'n', 'x'}, ';', ':', {noremap=true})
key.set('n', '<leader>w', ':<C-u>w<CR>')
key.set('n', '<leader>q', ':<C-u>q<CR>')
key.set('n', 'G', 'Gzz')
key.set('n', 'n', 'nzz')
key.set('n', 'N', 'Nzz')
key.set('n', '}', '}zz')
key.set('n', '{', '{zz')
key.set('n', 'x', '"_x')
key.set('n', '<C-d>', '<C-d>zz')
key.set('n', '<C-d>', '<C-u>zz')
key.set('n', 'mm', 'ddp', {noremap=true})
key.set('n', '<leader>s', ':<C-u>split<CR><C-w>w', {noremap=true, silent=true})
key.set('n', '<leader>v', ':<C-u>vsplit<CR><C-w>w', {noremap=true, silent=true})
key.set('n', '<leader>t', ':<C-u>tabnew<CR>', {noremap=true, silent=true})
key.set('n', 'g]', ':<C-u>tabnext<CR>', {noremap=true, silent=true})
key.set('n', 'g[', ':<C-u>tabprevious<CR>', {noremap=true, silent=true})
key.set('i', '<C-p>', '<Up>')
key.set('i', '<C-n>', '<Down>')
key.set('i', '<C-b>', '<Left>')
key.set('i', '<C-f>', '<Right>')
key.set('i', '<C-a>', '<C-o>:call home()<CR>')
key.set('i', '<C-e>', '<End>')
key.set('i', '<C-d>', '<Del>')
key.set('i', '<C-h>', '<BS>')
key.set('n', '<ESC><ESC>', ':<C-u>nohlsearch<CR>', {silent=true})

-- vp doesn't replace paste buffer
vim.cmd [[
  function! RestoreRegister()
    let @" = g:restore_reg
    return ''
  endfunction

  function! g:Repl()
    let g:restore_reg = @"
    return "p@=RestoreRegister()\<cr>"
  endfunction

  vmap <silent> <expr> p Repl()
]]

-- find and replace
vim.cmd [[
  vnoremap <silent> s //e<C-r>=&selection=='exclusive'?'+1':''<CR><CR>
      \:<C-u>call histdel('search',-1)<Bar>let @/=histget('search',-1)<CR>gv
  omap s :normal vs<CR>
]]
