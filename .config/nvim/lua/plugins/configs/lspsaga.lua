local function config()
	local colors = require("theme").colors
	require("lspsaga").setup({
		code_action = {
			num_shortcut = true,
		},
		definition = {
			edit = "<CR>",
			vsplit = "mv",
			split = "ms",
			tabe = "t",
			quit = "q",
			close = "<Esc>",
		},
		diagnostic = {
			show_code_action = true,
			show_source = true,
			jump_num_shortcut = true,
		},
		lightbulb = {
			enable = true,
			sign = false,
			enable_in_insert = true,
			sign_priority = 20,
			virtual_text = false,
		},
		-- finder_icons = {
		-- 	def = "  ",
		-- 	ref = "  ",
		-- 	link = "  ",
		-- },
		finder_request_timeout = 1500,
		rename = {
			quit = "<C-c>",
			exec = "<CR>",
			mark = "x",
			confirm = "<CR>",
			in_select = true,
			whole_project = true,
		},
		symbol_in_winbar = {
			enable = false,
			separator = "  ",
			hide_keyword = false,
			show_file = true,
			respect_root = false,
			color_mode = true,
		},
		outline = {
			win_position = "right",
			win_with = "",
			win_width = 30,
			show_detail = true,
			auto_preview = true,
			auto_refresh = true,
			auto_close = true,
			custom_sort = nil,
			keys = {
				jump = "<CR>",
				expand_collapse = "u",
				quit = "q",
			},
		},
		beacon = {
			enable = false,
		},
		ui = {
			theme = "round",
			border = "rounded",
			winblend = 10,
			expand = "",
			collapse = "",
			preview = " ",
			code_action = "💡",
			diagnostic = "🐞",
			incoming = "󰏷 ",
			outgoing = "󰏻 ",
			colors = {
				normal_bg = colors.gray,
				red = colors.red,
				magenta = colors.red,
				orange = colors.yellow,
				yellow = colors.yellow,
				green = colors.green,
				cyan = colors.cyan,
				blue = colors.blue,
				purple = colors.purple,
				white = colors.white,
				black = colors.gray,
			},
			kind = {},
		},
	})

	-- Only jump to error
	-- local function goto_next_error()
	-- 	require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
	-- end
	-- local function goto_prev_error()
	-- 	require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
	-- end
end

return {
	"nvimdev/lspsaga.nvim",
	cmd = { "Lspsaga" },
	keys = {
		{ "K", "<Cmd>Lspsaga hover_doc<CR>", mode = "n", desc = "LSP: Hover document with floating window" },
		{ "gp", "<Cmd>Lspsaga peek_definition<CR>", mode = "n", desc = "LSP: [G]oto [P]eek window" },
		{ "gP", "<cmd>Lspsaga lsp_finder<CR>", mode = "n", desc = "LSP: Goto symbol Finder" },
		{ "<C-j>", "<Cmd>Lspsaga diagnostic_jump_next<CR>", mode = "n", desc = "LSP: Jump to next diagnostic" },
		{ "<C-k>", "<Cmd>Lspsaga diagnostic_jump_prev<CR>", mode = "n", desc = "LSP: Jump to previous diagnostic" },
		{ "go", "<cmd>Lspsaga outline<CR>", mode = "n", desc = "LSP: Toggle [O]utline" },
		{ "<leader>r", "<Cmd>Lspsaga rename<CR>", mode = "n", desc = "LSP: [R]ename Symbol" },
		{ "<leader>a", "<cmd>Lspsaga code_action<CR>", mode = "n", desc = "LSP: Execute Code [A]ction" },
		{ "<leader>a", "<cmd>Lspsaga range_code_action<CR>", mode = "v", desc = "LSP: Code [A]ction to Selected Code" },
	},
	dependencies = {
		{ "nvim-tree/nvim-web-devicons" },
		{ "nvim-treesitter/nvim-treesitter" },
	},
	config = config,
}
