vim.g.mapleader = " "

local key = vim.keymap

-- key.set('n', '<space>', '<leader>', {noremap=true})
key.set('i', 'jj', '<ESC>', { noremap = true, silent = true })
key.set('n', '<leader>w', ':<C-u>w<CR>')
key.set('n', '<leader>q', ':<C-u>q<CR>')
key.set('n', 'mm', 'ddp', { noremap = true })
key.set('n', '<leader>s', ':<C-u>split<CR><C-w>w', { noremap = true, silent = true })
key.set('n', '<leader>v', ':<C-u>vsplit<CR><C-w>w', { noremap = true, silent = true })
key.set('n', '<leader>t', ':<C-u>tabnew<CR>', { noremap = true, silent = true })
key.set('n', '<leader>]', ':<C-u>tabnext<CR>', { noremap = true, silent = true })
key.set('n', '<leader>[', ':<C-u>tabprevious<CR>', { noremap = true, silent = true })
key.set('n', '<ESC><ESC>', ':<C-u>nohlsearch<CR>', { silent = true })
key.set('n', '<Up>', '<CMD>resize +1<CR>', { noremap = true })
key.set('n', '<Down>', '<CMD>resize -1<CR>', { noremap = true })
key.set('n', '<Left>', '<CMD>vertical resize +1<CR>', { noremap = true })
key.set('n', '<Right>', '<CMD>vertical resize -1<CR>', { noremap = true })
key.set({ 'c', 'i' }, '<C-p>', '<Up>', { noremap = true })
key.set({ 'c', 'i' }, '<C-n>', '<Down>', { noremap = true })
key.set({ 'c', 'i' }, '<C-b>', '<Left>', { noremap = true })
key.set({ 'c', 'i' }, '<C-f>', '<Right>', { noremap = true })
key.set({ 'c', 'i' }, '<C-a>', '<Home>', { noremap = true })
key.set({ 'c', 'i' }, '<C-e>', '<End>', { noremap = true })
key.set({ 'c', 'i' }, '<C-d>', '<Del>', { noremap = true })
key.set({ 'c', 'i' }, '<C-h>', '<BS>', { noremap = true })
key.set({ 'n', 'x' }, ';', ':', { noremap = true })
key.set({ 'n', 'x' }, 'G', 'Gzz')
key.set({ 'n', 'x' }, 'n', 'nzz')
key.set({ 'n', 'x' }, 'N', 'Nzz')
key.set({ 'n', 'x' }, '}', '}zz')
key.set({ 'n', 'x' }, '{', '{zz')
key.set({ 'n', 'x' }, 'x', '"_x')
key.set({ 'n', 'x' }, '<C-d>', '<C-d>zz')
key.set({ 'n', 'x' }, '<C-d>', '<C-u>zz')
key.set({ 'n', 'x' }, 'gh', 'g^')
key.set({ 'n', 'x' }, 'gl', 'g$')

key.set('n', '<C-n>', ':<C-u>cnext<CR>')
key.set('n', '<C-p>', ':<C-u>cprevious<CR>')

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
