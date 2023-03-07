---Set keymap
---@param mode string | table Mode short name or list of modes
---@param keys string Left-hand side {lhs} of the mapping.
---@param cmd string Right-hand side {rhs} of the mapping.
local function keymap(mode, keys, cmd)
	vim.keymap.set(mode, keys, cmd, { noremap = true, silent = true })
end

keymap("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "


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
keymap("i", "jj", "<ESC>")
keymap("n", "<leader>w", ":<C-u>w<CR>")
keymap("n", "<leader>q", ":<C-u>q<CR>")
keymap("n", "mm", "ddp")
keymap("n", "<leader>s", ":<C-u>split<CR><C-w>w")
keymap("n", "<leader>v", ":<C-u>vsplit<CR><C-w>w")
keymap("n", "<leader><Tab>", ":<C-u>tabnew<CR>")
keymap("n", "<Tab>]", ":<C-u>tabnext<CR>")
keymap("n", "<Tab>[", ":<C-u>tabprevious<CR>")
keymap("n", "<ESC><ESC>", ":<C-u>nohlsearch<CR>")
keymap("n", "<Up>", "<CMD>resize +1<CR>")
keymap("n", "<Down>", "<CMD>resize -1<CR>")
keymap("n", "<Left>", "<CMD>vertical resize +1<CR>")
keymap("n", "<Right>", "<CMD>vertical resize -1<CR>")
keymap("n", "<leader>l", ":cclose|lclose<CR>")
keymap({ "c", "i" }, "<C-p>", "<Up>")
keymap({ "c", "i" }, "<C-n>", "<Down>")
keymap({ "c", "i" }, "<C-b>", "<Left>")
keymap({ "c", "i" }, "<C-f>", "<Right>")
keymap({ "c", "i" }, "<C-a>", "<Home>")
keymap({ "c", "i" }, "<C-e>", "<End>")
keymap({ "c", "i" }, "<C-d>", "<Del>")
keymap({ "c", "i" }, "<C-h>", "<BS>")
keymap({ "n", "x" }, ";", ":")
keymap({ "n", "x" }, "G", "Gzz")
keymap({ "n", "x" }, "n", "nzz")
keymap({ "n", "x" }, "N", "Nzz")
keymap({ "n", "x" }, "}", "}zz")
keymap({ "n", "x" }, "{", "{zz")
keymap({ "n", "x" }, "x", '"_x')
keymap({ "n", "x" }, "s", '"_s')
keymap({ "n", "x" }, "<C-d>", "<C-d>zz")
keymap({ "n", "x" }, "<C-d>", "<C-u>zz")
keymap({ "n", "x" }, "gh", "g^")
keymap({ "n", "x" }, "gl", "g$")
