local function config()
	require("nvim-surround").setup()
end

return {
	"kylechui/nvim-surround",
	event = { "BufRead" },
	config = config,
}
