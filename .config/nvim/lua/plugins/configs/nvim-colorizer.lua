local function config()
	require("colorizer").setup({
		"*",
		css = { css = true, css_fn = true, RRGGBBAA = true },
		html = { names = false },
	})
end

return {
	"norcalli/nvim-colorizer.lua",
	event = { "BufNewFile", "BufRead" },
	config = config,
}
