local function config()
	require("fidget").setup({})
end

return {
	"j-hui/fidget.nvim",
	event = { "BufRead" },
	config = config,
}
