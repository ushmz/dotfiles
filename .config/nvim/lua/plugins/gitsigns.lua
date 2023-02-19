local function config()
	require("gitsigns").setup({})
end

return {
	"lewis6991/gitsigns.nvim",
	event = { "BufEnter" },
	config = config,
}
