return {
	"Wansmer/treesj",
	keys = { "<C-s>m", "<C-s>M", "<C-s>j", "<C-s>s" },
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	config = function()
		require("treesj").setup({
			use_default_keymaps = false,
		})

		-- It works with dot
		vim.keymap.set("n", "<C-s>m", require("treesj").toggle)
		-- It does't work with dot
		vim.keymap.set("n", "<C-s>M", function()
			require("treesj").toggle({ split = { recursive = true } })
		end)
		vim.keymap.set("n", "<C-s>j", require("treesj").join)
		vim.keymap.set("n", "<C-s>s", require("treesj").split)
	end,
}
