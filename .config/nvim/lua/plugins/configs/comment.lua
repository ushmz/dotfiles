local function config()
	require("Comment").setup({
		pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
		toggler = {
			line = "g/",
			block = "g*",
		},
		opleader = {
			line = "gc",
			block = "gb",
		},
	})
end

return {
	"numToStr/Comment.nvim",
	event = { "BufNewFile", "BufRead" },
	config = config,
}
