return {
	"RRethy/vim-illuminate",
	event = { "CursorHold" },
	config = function()
		require("illuminate").configure({
			filetypes_denylist = {
				"cmp_docs",
				"cmp_menu",
				"dirvish",
				"fugitive",
				"lazy",
				"markdown",
				"noice",
				"prompt",
				"TelescopePrompt",
			},
		})
		vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "CursorLine" })
		vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "CursorLine" })
		-- vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "CursorLine"})
	end,
}
