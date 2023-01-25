local ok, snip = pcall(require, "luasnip")
if not ok then
	return
end

-- Keymaps are defined in completion config.

require("luasnip.loaders.from_vscode").lazy_load()
snip.filetype_extend("typescript", { "javascript" })
snip.filetype_extend("bash", { "zsh" })
snip.filetype_extend("ruby", { "rails" })

require("luasnip.loaders.from_lua").lazy_load()
