local function config()
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
		finder_icons = {
			def = "  ",
			ref = "諭 ",
			link = "  ",
		},
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
			-- title = true,
			border = "rounded",
			winblend = 0,
			expand = "",
			collapse = "",
			preview = " ",
			code_action = "💡",
			diagnostic = "🐞",
			incoming = " ",
			outgoing = " ",
			colors = {
				normal_bg = "#1D1F21",
				--title background color
				-- title_bg = '#B5BD68',
				red = "#CC6666",
				magenta = "#CC6666",
				orange = "#DE935F",
				yellow = "#F0C674",
				green = "#B5BD68",
				cyan = "#8aBEB7",
				blue = "#81A2BE",
				purple = "#B294BB",
				white = "#C5C8C6",
				black = "#1D1F21",
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
	"glepnir/lspsaga.nvim",
	cmd = { "Lspsaga" },
	keys = {
		{ "<C-j>", "<Cmd>Lspsaga diagnostic_jump_next<CR>", mode = "n", desc = "Jump to next diagnostic" },
		{ "<C-k>", "<Cmd>Lspsaga diagnostic_jump_prev<CR>", mode = "n", desc = "Jump to previous diagnostic" },
		-- { "<C-k>", "<Cmd>Lspsaga signature_help<CR>", mode = "i", desc = "" },
		{ "<leader>o", "<cmd>Lspsaga outline<CR>", mode = "n", desc = "Toggle outline" },
		{ "<leader>r", "<Cmd>Lspsaga rename<CR>", mode = "n", desc = "Rename symbol" },
		{ "<leader>a", "<cmd>Lspsaga code_action<CR>", mode = "n", desc = "Execute code action" },
		{ "<leader>a", "<cmd>Lspsaga range_code_action<CR>", mode = "v", desc = "Code action to selected code" },
		{ "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", mode = "n", desc = "Show diagnostic message" },
		{ "gf", "<cmd>Lspsaga lsp_finder<CR>", mode = "n", desc = "Find definition of symbol" },
		{ "gp", "<Cmd>Lspsaga peek_definition<CR>", mode = "n", desc = "Peek definition with floating window" },
		{ "K", "<Cmd>Lspsaga hover_doc<CR>", mode = "n", desc = "Hover document with floating window" },
	},
	dependencies = {
		{ "nvim-tree/nvim-web-devicons" },
		{ "nvim-treesitter/nvim-treesitter" },
	},
	config = config,
}
