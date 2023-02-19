local function config()
	require("Comment").setup({
		toggler = {
			line = "<Leader>c",
			block = "<Leader>b",
		},
		opleader = {
			line = "<Leader>c",
			block = "<Leader>b",
		},
	})
end

return {
	"numToStr/Comment.nvim",
	event = { "BufEnter" },
	config = config,
}
