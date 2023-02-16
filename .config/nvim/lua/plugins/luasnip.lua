local ok, snip = pcall(require, "luasnip")
if not ok then
	return
end

---Plugin configs.
---@type { config: function, setup: function}
local M = {}

M.config = function()
	-- Keymaps are defined in completion config.
	require("luasnip.loaders.from_vscode").lazy_load()
	snip.filetype_extend("typescript", { "javascript" })
	snip.filetype_extend("bash", { "zsh" })
	snip.filetype_extend("ruby", { "rails" })

	require("luasnip.loaders.from_lua").lazy_load()
end

return M
