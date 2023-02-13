-- Add filetype options
vim.filetype.add({
	filename = {
		Brewfile = "ruby",
		Tmuxfile = "tmux",
		["go.sum"] = "go",
		["yarn.lock"] = "yaml",
		[".jscsrc"] = "json",
	},
	pattern = {
		[".*%.js%.map"] = "json",
		[".*%.postman_collection"] = "json",
		["%.config/git/users/.*"] = "gitconfig",
		[".*%.json%.jbuilder"] = "ruby",
	},
})

---Filetype options. If key doesn't exist, return default config.
---@type table<string, function>
local M = {}

---Set indent options
---@param length number Number of spaces that a <Tab> in the file counts for
---@param expandtab boolean Replace <Tab> to appropriate number of spaces or not
local function indent(length, expandtab)
	vim.bo.shiftwidth = length
	vim.bo.softtabstop = length
	vim.bo.tabstop = length
	vim.bo.expandtab = expandtab
end

M.help = function()
	vim.api.nvim_buf_set_keymap(0, "n", "q", "ZZ", { noremap = true })
end

M.dart = function()
	indent(2, true)
end

M.lua = function()
	indent(2, true)
end

M.vim = function()
	indent(2, true)
end

M.javascript = function()
	indent(2, true)
end

M.javascriptreact = function()
	indent(2, true)
end

M.typescript = function()
	indent(2, true)
end

M.typescriptreact = function()
	indent(2, true)
end

return setmetatable(M, {
	__index = function()
		return function()
			indent(4, true)
		end
	end,
})
