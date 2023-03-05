local function treesitter()
	local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
	parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }

	require("nvim-treesitter.configs").setup({
		highlight = { enable = true },
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
			"regex",
			"ruby",
			"rust",
			"scss",
			"toml",
			"tsx",
			"typescript",
			"vim",
			"vue",
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
	})
end

local function treesitter_context()
	require("treesitter-context").setup({
		enable = true,
		max_lines = 0,
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
end

return {
	{
		"nvim-treesitter/nvim-treesitter",
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
}