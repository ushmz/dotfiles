local function config()
	require("hlslens").setup()

	local opts = { noremap = true, silent = true }

	vim.keymap.set(
		"n",
		"n",
		[[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>zz]],
		opts
	)
	vim.keymap.set(
		"n",
		"N",
		[[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>zz]],
		opts
	)
	vim.keymap.set("n", "*", [[*<Cmd>lua require('hlslens').start()<CR>]], opts)
	vim.keymap.set("n", "#", [[#<Cmd>lua require('hlslens').start()<CR>]], opts)
	vim.keymap.set("n", "g*", [[g*<Cmd>lua require('hlslens').start()<CR>]], opts)
	vim.keymap.set("n", "g#", [[g#<Cmd>lua require('hlslens').start()<CR>]], opts)

	local colors = require("kanagawa.colors").setup({ theme = "dragon" })
	local set_hl = require("theme").set_hl
	set_hl("HlSearchNear", { bg = colors.palette.dragonYellow, fg = colors.palette.dragonBlack0 })
	set_hl("HlSearchLens", { bg = colors.palette.dragonGreen2, fg = colors.palette.dragonBlack0 })
	set_hl("HlSearchLensNear", { bg = colors.palette.dragonYellow, fg = colors.palette.dragonBlack0 })
end

return {
	"kevinhwang91/nvim-hlslens",
	event = { "BufNewFile", "BufRead" },
	config = config,
}
