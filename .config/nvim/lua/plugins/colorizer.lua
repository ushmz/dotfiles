local function config()
	require("colorizer").setup({
		"*",
		css = { css = true, RRGGBBAA = true },
		html = { names = false },
	})
end

return {
	"norcalli/nvim-colorizer.lua",
	event = { "BufRead" },
	config = config,
}
