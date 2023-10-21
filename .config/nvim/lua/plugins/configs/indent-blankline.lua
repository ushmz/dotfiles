local function config()
	require("ibl").setup({ scope = { show_exact_scope = true } })
end

return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	event = { "BufNewFile", "BufRead" },
	config = config,
}
