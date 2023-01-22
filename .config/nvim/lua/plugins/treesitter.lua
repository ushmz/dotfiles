local ok, ts = pcall(require, "nvim-treesitter.configs")
if not ok then
	return
end

ts.setup({
	highlight = { enable = true },
	indent = { enable = true },
	yati = { enable = true },
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
	autotag = {
		enable = true,
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

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
