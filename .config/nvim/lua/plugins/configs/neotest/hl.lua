local M = {}

M.set = function()
	vim.api.nvim_set_hl(0, "NeotestPassed", { fg = "#B5BD68" })
	vim.api.nvim_set_hl(0, "NeotestFailed", { fg = "#CC6666" })
	vim.api.nvim_set_hl(0, "NeotestRunning", { fg = "#F0C674" })
	vim.api.nvim_set_hl(0, "NeotestSkipped", { fg = "#81A2BE" })
	vim.api.nvim_set_hl(0, "NeotestFile", { fg = "#81A2BE" })
	vim.api.nvim_set_hl(0, "NeotestDir", { fg = "#8ABEB7" })
	vim.api.nvim_set_hl(0, "NeotestNamespace", { fg = "#B5BD68" })
	vim.api.nvim_set_hl(0, "NeotestFocused", { bold = true, underline = true, bg = "#464749" })
	vim.api.nvim_set_hl(0, "NeotestIndent", { fg = "#808080" })
	vim.api.nvim_set_hl(0, "NeotestExpandMarker", { fg = "#81A2BE" })
	vim.api.nvim_set_hl(0, "NeotestAdapterName", { fg = "#CC6666" })
	vim.api.nvim_set_hl(0, "NeotestWinSelect", { fg = "#8aBEB7", bold = true })
	vim.api.nvim_set_hl(0, "NeotestMarked", { fg = "#F0C674", bold = true })
	vim.api.nvim_set_hl(0, "NeotestTarget", { fg = "#CC6666" })
	vim.api.nvim_set_hl(0, "NeotestTest", { fg = "#D4D4D4" })
end

return M
