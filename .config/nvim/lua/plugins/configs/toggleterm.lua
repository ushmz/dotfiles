local function toggle_term()
	local term = require("toggleterm.terminal").Terminal:new({})
	term:toggle()
end

local function toggle_tig()
	local tig = require("toggleterm.terminal").Terminal:new({ cmd = "tig" })
	tig:toggle()
end

local function config()
	require("toggleterm").setup({
		hidden = true,
		direction = "float",
		float_opts = {
			border = "curved",
		},
	})
end

return {
	"akinsho/toggleterm.nvim",
	module = { "toggleterm" },
	keys = {
		{ [[<C-w>\]], toggle_term, mode = "n", desc = "Toggle default shell terminal" },
		{ [[<C-w>t]], toggle_tig, mode = "n", desc = "Toggle default shell terminal with tig" },
	},
	config = config,
}
