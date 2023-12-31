return {
	"Wansmer/treesj",
	keys = { "<space>j" },
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	config = function()
		require("treesj").setup({
			use_default_keymaps = false,
		})

		vim.keymap.set("n", "<space>j", require("treesj").toggle)
	end,
}
