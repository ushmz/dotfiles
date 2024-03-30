local M = {}

---Returns the jest file for the given file
---@param _ string
---@return string
function M.jest(_)
	local workspace = vim.fn.getcwd()
	local relative = vim.fn.expand("%:~:.")
	if relative:match("^src") then
		return workspace .. "/" .. relative:gsub("src", "__tests__", 1):gsub(".ts$", ".test.ts")
	elseif relative:match("^__tests__") then
		return workspace .. "/" .. relative:gsub("__tests__", "src", 1):gsub(".test.ts$", ".ts")
	else
		vim.api.nvim_err_writeln("Not a jest file")
		return ""
	end
end

---Returns the storybook file for the given file
---@param _ string
---@return string
function M.storybook(_)
	local workspace = vim.fn.getcwd()
	local relative = vim.fn.expand("%:~:.")
	if relative:match("^src") then
		return workspace .. "/" .. relative:gsub("src", "__stories__", 1):gsub(".ts$", ".stories.ts")
	elseif relative:match("^__stories__") then
		return workspace .. "/" .. relative:gsub("__stories__", "src", 1):gsub(".stories.ts$", ".ts")
	else
		vim.api.nvim_err_writeln("Not a storybook file")
		return ""
	end
end

return M
