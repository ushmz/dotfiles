local function config()
	-- Keymaps are defined in completion config.
	local snip = require("luasnip")
	require("luasnip.loaders.from_vscode").lazy_load()
	snip.filetype_extend("typescript", { "javascript" })
	snip.filetype_extend("bash", { "zsh" })
	snip.filetype_extend("ruby", { "rails" })

	require("luasnip.loaders.from_lua").lazy_load()
end

return {
	"L3MON4D3/LuaSnip",
	dependencies = {
		{ "rafamadriz/friendly-snippets" },
	},
	event = { "InsertEnter" },
	config = config,
}
