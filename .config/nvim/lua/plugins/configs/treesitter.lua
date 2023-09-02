local function treesitter()
	local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
	parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }

	require("nvim-treesitter.configs").setup({
		highlight = {
			enable = true,
			disable = function(lang, buf)
				local MAX_FILESIZE = 2 * 1024 * 1024
				local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
				if ok and stats and stats.size > MAX_FILESIZE then
					return true
				end
			end,
		},
		indent = { enable = true },
		autotag = { enable = true },
		endwise = { enable = true },
		ensure_installed = {
			"bash",
			"css",
			"dart",
			"dockerfile",
			"go",
			"gomod",
			"html",
			"java",
			"javascript",
			"json",
			"jsonc",
			"kotlin",
			"lua",
			"make",
			"markdown",
			"markdown_inline",
			"prisma",
			"python",
			"query",
			"regex",
			"ruby",
			"rust",
			"scss",
			"toml",
			"tsx",
			"typescript",
			"vim",
			"yaml",
		},
		textobjects = {
			select = {
				enable = true,
				lookahead = true,
				keymaps = {
					["af"] = "@function.outer",
					["if"] = "@function.inner",
					["ac"] = "@class.outer",
					["ic"] = "@class.inner",
					["al"] = "@loop.outer",
					["il"] = "@loop.inner",
					["ib"] = "@block.inner",
					["ab"] = "@block.outer",
					["ir"] = "@parameter.inner",
					["ar"] = "@parameter.outer",
				},
			},
			move = {
				enable = true,
				set_jumps = true,
				goto_next_start = {
					-- ['g['] = '@function.outer',
					-- ['[['] = '@class.outer',
				},
				goto_next_end = {
					-- ['g]'] = '@function.outer',
					-- [']]'] = '@class.outer',
				},
				goto_previous_start = {
					-- ['[m'] = '@function.outer',
					-- ['[['] = '@class.outer',
				},
				goto_previous_end = {
					-- ['[M'] = '@function.outer',
					-- ['[]'] = '@class.outer',
				},
			},
		},
		playground = {
			enable = true,
			disable = {},
			updatetime = 25,
			persist_queries = false,
			keybindings = {
				toggle_query_editor = "o",
				toggle_hl_groups = "i",
				toggle_injected_language = "t",
				toggle_anonymous_nodes = "a",
				toggle_language_display = "I",
				focus_language = "f",
				unfocus_language = "F",
				update = "R",
				goto_node = "<CR>",
				show_help = "?",
			},
		},
		rainbow = {
			enable = true,
			---@type string[]
			disable = { "cpp" },
			---Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
			---@type boolean|table<string, boolean>
			extended_mode = false,
			-- Do not enable for files with more than n lines, int
			max_file_lines = nil,
			-- colors = {}, -- table of hex strings
			-- termcolors = {} -- table of colour name strings
		},
	})
end

local function treesitter_context()
	require("treesitter-context").setup({
		enable = true,
		max_lines = 10,
		trim_scope = "outer",
		min_window_height = 0,
		patterns = {
			default = {
				"class",
				"function",
				"method",
				"for",
				"while",
				"if",
				"switch",
				"case",
				"interface",
				"struct",
				"enum",
			},
			markdown = {
				"section",
			},
			json = {
				"pair",
			},
			typescript = {
				"export_statement",
			},
			yaml = {
				"block_mapping_pair",
			},
		},
		exact_patterns = {},
	})
	-- Set keymap to go to the outer context
	vim.keymap.set("n", "[c", function()
		require("treesitter-context").go_to_context()
	end, { silent = true })

	-- Set highlights
	vim.api.nvim_set_hl(0, "TreesitterContext", { bg = "#282A2E" })
	vim.api.nvim_set_hl(0, "TreesitterContextLineNumber", { bg = "#282A2E" })
	vim.api.nvim_set_hl(0, "TreesitterContextBottom", { fg = "#808080", underline = true })
end

return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufRead" },
		config = treesitter,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = { "BufRead" },
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = treesitter_context,
	},
	{
		"RRethy/nvim-treesitter-endwise",
		event = { "InsertEnter" },
		dependencies = { "nvim-treesitter/nvim-treesitter" },
	},
	{
		"nvim-treesitter/playground",
		event = { "BufRead" },
		dependencies = { "nvim-treesitter/nvim-treesitter" },
	},

	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		event = { "BufRead" },
		dependencies = { "nvim-treesitter/nvim-treesitter" },
	},
}
