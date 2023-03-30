local function t()
	return require("telescope")
end

local function b()
	return require("telescope.builtin")
end

local function buffers()
	b().buffers({})
end

local function commands()
	b().commands({})
end

local function diagnostics()
	b().diagnostics({})
end

local function help_tags()
	b().help_tags({})
end

local function keymaps()
	b().keymaps({})
end

local function oldfiles()
	b().oldfiles({})
end

local function resume()
	b().resume({})
end

local function references()
	b().lsp_references({
		include_declaration = false,
		include_current_line = false,
	})
end

local function implementations()
	b().lsp_implementations({})
end

local function type_definitions()
	b().lsp_type_definitions({})
end

local function document_symbols()
	b().lsp_document_symbols({})
end

local function workspace_symbols()
	b().lsp_dynamic_workspace_symbols({})
end

local function find_files()
	b().find_files({
		no_ignore = false,
		hidden = true,
	})
end

local function live_grep()
	b().live_grep({})
end

local function file_browser()
	t().load_extension("file_browser")
	t().extensions["file_browser"]["file_browser"]({
		path = "%:p:h",
		cwd = vim.fn.expand("%:p:h"),
		respect_gitignore = false,
		hidden = true,
		grouped = true,
		previewer = false,
		initial_mode = "normal",
		layout_config = { height = 40 },
	})
end

local function harpoon()
	t().load_extension("harpoon")
	vim.cmd("Telescope harpoon marks")
end

local max_size = 100000
---Ignore files bigger than a threshold
---@param filepath string
---@param bufnr number
---@param opts table
local function new_maker(filepath, bufnr, opts)
	opts = opts or {}
	filepath = vim.fn.expand(filepath)
	vim.loop.fs_stat(filepath, function(_, stat)
		if not stat then
			return
		end
		if stat.size > max_size then
			local cmd = { "head", "-c", max_size, filepath }
			require("telescope.previewers.utils").job_maker(cmd, bufnr, opts)
		else
			require("telescope.previewers").buffer_previewer_maker(filepath, bufnr, opts)
		end
	end)
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
		{ ";b", buffers, mode = "n", desc = "Telescope: Search [B]uffers" },
		{ ";c", commands, mode = "n", desc = "Telescope: Search [C]ommands" },
		{ ";e", diagnostics, mode = "n", desc = "Telescope: Search diagnostics ([E]rrors)" },
		{ ";h", help_tags, mode = "n", desc = "Telescope: Search [H]elps" },
		{ ";k", keymaps, mode = "n", desc = "Telescope: Search [K]eymaps" },
		{ ";o", oldfiles, mode = "n", desc = "Telescope: Search [O]ldfiles" },
		{ ";;", resume, mode = "n", desc = "Telescope: Resume latest search" },
		{ ";f", find_files, mode = "n", desc = "Telescope: Search [F]iles" },
		{ ";g", live_grep, mode = "n", desc = "Telescope: Live [G]rep" },
		{ ";d", file_browser, mode = "n", desc = "Telescope: [D]irectory & File Browser" },
		{ ";m", harpoon, mode = "n", desc = "Telescope: Search Harpoon [M]arks" },
		{ "<leader>ds", document_symbols, mode = "n", desc = "Telescope: [D]ocument [S]ymbols" },
		{ "<leader>ws", workspace_symbols, mode = "n", desc = "Telescope: [W]orkspace [S]ymbols" },
		{ "gr", references, mode = "n", desc = "LSP: [G]oto [R]eferences" },
		{ "gi", implementations, mode = "n", desc = "LSP: [G]oto [I]mplementations" },
		{ "gt", type_definitions, mode = "n", desc = "LSP: [G]oto [T]ype definitions" },
	},
	config = function()
		local actions = require("telescope.actions")
		local fb_actions = require("telescope").extensions.file_browser.actions

		t().setup({
			defaults = {
				buffer_previewer_maker = new_maker,
				mappings = {
					n = {
						["q"] = actions.close,
					},
				},
				file_ignore_patterns = {
					"*.DS_Store",
					"*.pyc",
					".cache/",
					".cargo/",
					".git/",
					".npm/",
					".ssh/",
					"node_modules/",
					"site_packages/",
					"__pycache__/",
				},
			},
			vimgrep_arguments = {
				"rg",
				"-L",
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
				"--smart-case",
			},
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
	end,
}
