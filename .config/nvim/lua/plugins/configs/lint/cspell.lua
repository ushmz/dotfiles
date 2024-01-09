---@class Cspell
---@field args table
---@field append_to_dictionary function
local M = {}

M.args = {
	"lint",
	"--no-color",
	"--no-progress",
	"--no-summary",
	"--show-suggestions",
	"--config",
	"~/.config/cspell/cspell.json",
}

---Append a word to cspell dictionary
---@param opts table
function M.append_to_dictionary(opts)
	local word = opts.args
	if not word or word == "" then
		word = string.lower(vim.fn.expand("<cword>"))
	end

	local dictionary = opts.bang and "user" or "dotfiles"

	io.popen("echo " .. word .. " >> ~/.config/cspell/" .. dictionary .. ".txt")

	vim.notify("Added " .. word .. " to " .. dictionary .. " dictionary", vim.log.levels.INFO)

	-- HACK: Modify current line and undo to reload cspell
	if vim.api.nvim_get_option_value("modifiable", {}) then
		vim.api.nvim_set_current_line(vim.api.nvim_get_current_line())
		vim.api.nvim_command("silent! undo")
	end
end

return M
