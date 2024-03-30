---Set keymap
---@param mode string | table Mode short name or list of modes
---@param keys string Left-hand side {lhs} of the mapping.
---@param cmd string Right-hand side {rhs} of the mapping.
local function keymap(mode, keys, cmd, opts)
	vim.keymap.set(mode, keys, cmd, { noremap = true, silent = true, unpack(opts or {}) })
end

keymap("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

keymap("i", "jj", "<ESC>")
keymap("n", "<leader>w", ":<C-u>w<CR>")
keymap("n", "<leader>q", ":<C-u>q<CR>")
keymap("n", "mm", "ddp")
keymap("n", "<ESC><ESC>", ":<C-u>nohlsearch<CR>")
keymap("n", "<leader>l", ":cclose|lclose<CR>")
keymap("n", "<C-w>n", ":<C-u>tabnew<CR>")
keymap("n", "<C-w>[", ":<C-u>tabprev<CR>")
keymap("n", "<C-w>]", ":<C-u>tabnext<CR>")
keymap("v", "p", '"_xP')
keymap({ "n", "v" }, "gy", '"+y')
keymap({ "c", "i" }, "<C-p>", "<Up>")
keymap({ "c", "i" }, "<C-n>", "<Down>")
keymap({ "c", "i" }, "<C-b>", "<Left>")
keymap({ "c", "i" }, "<C-f>", "<Right>")
keymap({ "c", "i" }, "<C-a>", "<Home>")
keymap({ "c", "i" }, "<C-e>", "<End>")
keymap({ "c", "i" }, "<C-d>", "<Del>")
keymap({ "c", "i" }, "<C-h>", "<BS>")
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
