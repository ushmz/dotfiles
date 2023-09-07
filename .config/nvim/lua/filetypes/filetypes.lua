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

function M.dart()
	indent(2, true)
end

function M.go()
	indent(4, false)
end

function M.help()
	vim.api.nvim_buf_set_keymap(0, "n", "q", "ZZ", { noremap = true })
end

function M.javascript()
	indent(2, true)
end

function M.javascriptreact()
	indent(2, true)
end

function M.json()
	indent(2, true)
end

function M.jsonc()
	indent(2, true)
end

function M.lua()
	indent(2, true)
end

function M.make()
	indent(4, false)
end

function M.python()
	indent(4, false)
end

function M.ruby()
	indent(2, true)
end

function M.typescript()
	indent(2, true)
end

function M.typescriptreact()
	indent(2, true)
end

function M.vim()
	indent(2, true)
end

function M.yaml()
	indent(2, true)
end

return setmetatable(M, {
	__index = function()
		return function()
			indent(4, true)
		end
	end,
})
