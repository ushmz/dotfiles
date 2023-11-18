local pickers = require("plugins.configs.telescope.pickers")

local function config()
	local telescope = require("telescope")
	local actions = require("telescope.actions")
	local fb_actions = require("telescope").extensions.file_browser.actions
	local preview_maker = require("plugins.configs.telescope.preview_maker")

	local trouble = require("trouble.providers.telescope")

	telescope.setup({
		defaults = {
			sorting_strategy = "ascending",
			selection_strategy = "closest",
			scroll_strategy = "limit",
			layout_strategy = "flex",
			buffer_previewer_maker = preview_maker.create(100000),
			-- FIXME: It's not working with `telescope-file-browser`.
			-- Now I put this config in each picker.
			-- layout_config = {
			--   preview_width = 0.4,
			-- },
			mappings = {
				i = {
					["<C-o>"] = trouble.open_with_trouble,
				},
				n = {
					["q"] = actions.close,
					["<C-o>"] = trouble.open_with_trouble,
				},
			},
			file_ignore_patterns = {
				".DS_Store",
				"*.pyc",
				".cargo/",
				".git/",
				".npm/",
				".ssh/",
				"node_modules/",
				"site_packages/",
				"__pycache__/",
			},
		},
		-- NOTE: To add `--hidden` option to `vimgrep_arguments` is not working.
		-- Config in each picker instead.
		pickers = {
			find_files = {
				find_command = { "fd", "--type", "f", "--strip-cwd-prefix" },
			},
			git_files = {
				git_command = { "git", "ls-files", "--exclude-standard", "--cached", "--others" },
			},
		},
		extensions = {
			file_browser = {
				theme = "dropdown",
				-- disables netrw and use telescope-file-browser in its place
				hijack_netrw = true,
				git_status = false,
				mappings = {
					["i"] = {
						["<C-w>"] = function()
							vim.cmd("normal vbd")
						end,
					},
					["n"] = {
						["h"] = fb_actions.goto_parent_dir,
						["H"] = fb_actions.toggle_hidden,
						["N"] = fb_actions.create,
						["r"] = fb_actions.rename,
						["D"] = fb_actions.remove,
						["/"] = function()
							vim.cmd("startinsert")
						end,
					},
				},
			},
			egrepify = {
				vimgrep_arguments = { "rg", "--hidden", "--glob", "!.git" },
				---FIXME: This causes extra lines in the bottom of the result.
				-- sorting_strategy = "ascending",
			},
		},
	})

	require("plugins.configs.telescope.hl").set()
end

return {
	"nvim-telescope/telescope.nvim",
	cmd = { "Telescope" },
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
		{ "BurntSushi/ripgrep" },
		{ "sharkdp/fd" },
		{ "nvim-telescope/telescope-file-browser.nvim" },
		{ "fdschmidt93/telescope-egrepify.nvim" },
	},
	keys = {
		{ ";;", pickers.resume, mode = "n", desc = "Telescope: Resume latest search" },
		{ ";b", pickers.buffers, mode = "n", desc = "Telescope: Search [B]uffers" },
		{ ";c", pickers.commands, mode = "n", desc = "Telescope: Search [C]ommands" },
		{ ";d", pickers.file_browser, mode = "n", desc = "Telescope: [D]irectory & File Browser" },
		{ ";e", pickers.diagnostics, mode = "n", desc = "Telescope: Search diagnostics ([E]rrors)" },
		{ ";f", pickers.find_files, mode = "n", desc = "Telescope: Search [F]iles" },
		{ ";g", pickers.live_grep, mode = "n", desc = "Telescope: Live [G]rep" },
		{ ";G", pickers.egrepify, mode = "n", desc = "Telescope: Search with e[G]repify" },
		{ ";h", pickers.help_tags, mode = "n", desc = "Telescope: Search [H]elps" },
		{ ";k", pickers.keymaps, mode = "n", desc = "Telescope: Search [K]eymaps" },
		{ ";sc", pickers.grep_string, mode = "n", desc = "Telescope: [S]earch word under the [C]ursor" },
		{
			";si",
			function()
				pickers.grep_string(vim.fn.input("Search: "))
			end,
			mode = "n",
			desc = "Telescope: [S]earch word from [I]nput",
		},
		{ ";o", pickers.oldfiles, mode = "n", desc = "Telescope: Search [O]ldfiles" },
		{ ";sd", pickers.document_symbols, mode = "n", desc = "Telescope: [S]ymbols in [D]ocument" },
		{ ";sw", pickers.workspace_symbols, mode = "n", desc = "Telescope: [S]ymbols in [W]orkspace" },
		{ "gi", pickers.implementations, mode = "n", desc = "LSP: [G]oto [I]mplementations" },
		{ "gr", pickers.references, mode = "n", desc = "LSP: [G]oto [R]eferences" },
		{ "gt", pickers.type_definitions, mode = "n", desc = "LSP: [G]oto [T]ype definitions" },
	},
	config = config,
}
