local ok, saga = pcall(require, "lspsaga")
if not ok then
	return
end

saga.setup({
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

local keymap = vim.keymap.set

local opts = { noremap = true, silent = true }
-- Diagnsotic jump can use `<c-o>` to jump back
keymap("n", "<C-j>", "<Cmd>Lspsaga diagnostic_jump_next<CR>", opts)
keymap("n", "<C-k>", "<Cmd>Lspsaga diagnostic_jump_prev<CR>", opts)

-- Only jump to error
keymap("n", "[E", function()
	require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, opts)
keymap("n", "]E", function()
	require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
end, opts)

-- Lsp finder find the symbol definition implement reference
-- if there is no implement it will hide
-- when you use action in finder like open vsplit then you can
-- use <C-t> to jump back
keymap("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opts)

-- Peek Definition
-- you can edit the definition file in this flaotwindow
-- also support open/vsplit/etc operation check definition_action_keys
-- support tagstack C-t jump back
keymap("n", "gp", "<Cmd>Lspsaga peek_definition<CR>", opts)

-- Outline
keymap("n", "<leader>o", "<cmd>Lspsaga outline<CR>", opts)

keymap("n", "<leader>r", "<Cmd>Lspsaga rename<CR>", opts)
keymap("n", "<leader>a", "<cmd>Lspsaga code_action<CR>", opts)
keymap("v", "<leader>a", "<cmd>Lspsaga range_code_action<CR>", opts)
keymap("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts)
-- keymap("n", "<leader>ld", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
keymap("n", "K", "<Cmd>Lspsaga hover_doc<CR>", opts)
-- vim.keymap.set('i', '<C-k>', '<Cmd>Lspsaga signature_help<CR>', opts)

vim.api.nvim_create_autocmd({ "BufRead" }, {
	pattern = { "*" },
	callback = function()
		-- Colors from 'hybrid.vim'
		vim.api.nvim_set_hl(0, "DiagnosticError", { fg = "#CC6666" })
		vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = "#F0C674" })
		vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = "#81A2BE" })
		vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = "#B5BD68" })
	end,
})
