local augroup = vim.api.nvim_create_augroup -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd -- Create autocommand

-- Don't auto commenting new lines
autocmd("BufEnter", {
	pattern = "*",
	command = "set fo-=c fo-=r fo-=o",
})

autocmd({ "FileType" }, {
	pattern = { "javascriptreact", "typescriptreact", "dart", "lua", "vim" },
	command = "set tabstop=2 shiftwidth=2 softtabstop=2",
})

autocmd({ "BufWritePost" }, {
	pattern = { "plugins.lua" },
	command = "PackerCompile",
})
