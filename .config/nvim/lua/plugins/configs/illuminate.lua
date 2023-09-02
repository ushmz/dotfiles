return {
	"RRethy/vim-illuminate",
	event = { "CursorHold" },
	config = function()
		vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "CursorLine" })
		vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "CursorLine" })
		-- vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "CursorLine"})
	end,
}
