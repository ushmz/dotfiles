local pickers = require("plugins.configs.telescope.pickers")

local function config()
	local telescope = require("telescope")
	local actions = require("telescope.actions")
	local fb_actions = require("telescope").extensions.file_browser.actions
	local preview_maker = require("plugins.configs.telescope.preview_maker")

	telescope.setup({
		defaults = {
			buffer_previewer_maker = preview_maker.create(100000),
			mappings = {
				n = {
					["q"] = actions.close,
				},
			},
			file_ignore_patterns = {
				"*.DS_Store",
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
		vimgrep_arguments = { "rg", "-L", "--vimgrep", "--smart-case" },
		pickers = {
			find_files = {
				find_command = { "fd", "--type", "f", "--strip-cwd-prefix" },
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
		{ "ThePrimeagen/harpoon" },
		{ "nvim-telescope/telescope-file-browser.nvim" },
	},
	keys = {
		{ ";;", pickers.resume, mode = "n", desc = "Telescope: Resume latest search" },
		{ ";b", pickers.buffers, mode = "n", desc = "Telescope: Search [B]uffers" },
		{ ";c", pickers.commands, mode = "n", desc = "Telescope: Search [C]ommands" },
		{ ";d", pickers.file_browser, mode = "n", desc = "Telescope: [D]irectory & File Browser" },
		{ ";e", pickers.diagnostics, mode = "n", desc = "Telescope: Search diagnostics ([E]rrors)" },
		{ ";f", pickers.find_files, mode = "n", desc = "Telescope: Search [F]iles" },
		{ ";g", pickers.live_grep, mode = "n", desc = "Telescope: Live [G]rep" },
		{ ";h", pickers.help_tags, mode = "n", desc = "Telescope: Search [H]elps" },
		{ ";k", pickers.keymaps, mode = "n", desc = "Telescope: Search [K]eymaps" },
		{ ";m", pickers.harpoon, mode = "n", desc = "Telescope: Search Harpoon [M]arks" },
		{ ";o", pickers.oldfiles, mode = "n", desc = "Telescope: Search [O]ldfiles" },
		{ ";ss", pickers.grep_string, mode = "n", desc = "Telescope: [S]earch [S]tring" },
		{ ";sd", pickers.document_symbols, mode = "n", desc = "Telescope: [S]ymbols in [D]ocument" },
		{ ";sw", pickers.workspace_symbols, mode = "n", desc = "Telescope: [S]ymbols in [W]orkspace" },
		{ "gi", pickers.implementations, mode = "n", desc = "LSP: [G]oto [I]mplementations" },
		{ "gr", pickers.references, mode = "n", desc = "LSP: [G]oto [R]eferences" },
		{ "gt", pickers.type_definitions, mode = "n", desc = "LSP: [G]oto [T]ype definitions" },
	},
	config = config,
}
