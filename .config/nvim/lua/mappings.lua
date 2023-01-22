vim.g.mapleader = " "

local key = vim.keymap
local opt = { noremap = true, silent = true }

-- key.set('n', '<space>', '<leader>', {noremap=true})
key.set("i", "jj", "<ESC>", opt)
key.set("n", "<leader>w", ":<C-u>w<CR>", opt)
key.set("n", "<leader>q", ":<C-u>q<CR>", opt)
key.set("n", "mm", "ddp", opt)
key.set("n", "<leader>s", ":<C-u>split<CR><C-w>w", opt)
key.set("n", "<leader>v", ":<C-u>vsplit<CR><C-w>w", opt)
key.set("n", "<leader><Tab>", ":<C-u>tabnew<CR>", opt)
key.set("n", "<Tab>]", ":<C-u>tabnext<CR>", opt)
key.set("n", "<Tab>[", ":<C-u>tabprevious<CR>", opt)
key.set("n", "<ESC><ESC>", ":<C-u>nohlsearch<CR>", opt)
key.set("n", "<Up>", "<CMD>resize +1<CR>", opt)
key.set("n", "<Down>", "<CMD>resize -1<CR>", opt)
key.set("n", "<Left>", "<CMD>vertical resize +1<CR>", opt)
key.set("n", "<Right>", "<CMD>vertical resize -1<CR>", opt)
key.set("n", "<leader>l", ":cclose|lclose<CR>", opt)
key.set({ "c", "i" }, "<C-p>", "<Up>", opt)
key.set({ "c", "i" }, "<C-n>", "<Down>", opt)
key.set({ "c", "i" }, "<C-b>", "<Left>", opt)
key.set({ "c", "i" }, "<C-f>", "<Right>", opt)
key.set({ "c", "i" }, "<C-a>", "<Home>", opt)
key.set({ "c", "i" }, "<C-e>", "<End>", opt)
key.set({ "c", "i" }, "<C-d>", "<Del>", opt)
key.set({ "c", "i" }, "<C-h>", "<BS>", opt)
key.set({ "n", "x" }, ";", ":", opt)
key.set({ "n", "x" }, "G", "Gzz", opt)
key.set({ "n", "x" }, "n", "nzz", opt)
key.set({ "n", "x" }, "N", "Nzz", opt)
key.set({ "n", "x" }, "}", "}zz", opt)
key.set({ "n", "x" }, "{", "{zz", opt)
key.set({ "n", "x" }, "x", '"_x', opt)
key.set({ "n", "x" }, "<C-d>", "<C-d>zz", opt)
key.set({ "n", "x" }, "<C-d>", "<C-u>zz", opt)
key.set({ "n", "x" }, "gh", "g^", opt)
key.set({ "n", "x" }, "gl", "g$", opt)

-- vp doesn't replace paste buffer
vim.cmd([[
  function! RestoreRegister()
    let @" = g:restore_reg
    return ''
  endfunction

  function! g:Repl()
    let g:restore_reg = @"
    return "p@=RestoreRegister()\<cr>"
  endfunction

  vmap <silent> <expr> p Repl()
]])
