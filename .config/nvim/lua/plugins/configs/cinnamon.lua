return {
	"declancm/cinnamon.nvim",
	event = { "BufRead", "BufNewFile" },
	config = function()
		require("cinnamon").setup({
			extra_keymaps = true,
			override_keymaps = true,
			max_length = 30,
			scroll_limit = -1,
		})
	end,
}
