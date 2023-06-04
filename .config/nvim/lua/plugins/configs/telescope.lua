local function t()
	return require("telescope")
end

local function b()
	return require("telescope.builtin")
end

---Check if it's inside git work tree
---@return boolean
local function is_git_repo()
	vim.fn.system("git rev-parse --is-inside-work-tree")
	return vim.v.shell_error == 0
end

---Get the root directory of the Git repository.
---@return string
local function get_git_root()
	local git_path = vim.fn.finddir(".git", ".;")
	return vim.fn.fnamemodify(git_path, ":h")
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
	local opts = { no_ignore = false, hidden = true }
	if is_git_repo() then
		b().git_files(opts)
	else
		b().find_files(opts)
	end
end

local function live_grep()
	local opts = {}
	if is_git_repo() then
		table.insert(opts, { cwd = get_git_root() })
	end
	b().live_grep(opts)
end

local function file_browser()
	t().load_extension("file_browser")
	t().extensions["file_browser"]["file_browser"]({
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

---If the result file is bigger than a `max_size`,
---stop reading after `max_size` bytes from the head.
---@param max_size number Max file size (bytes)
---@return fun(filepath: string, bufnr: number, opts: table): nil
local function new_preview_maker(max_size)
	return function(filepath, bufnr, opts)
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
		{ ";;", resume, mode = "n", desc = "Telescope: Resume latest search" },
		{ ";b", buffers, mode = "n", desc = "Telescope: Search [B]uffers" },
		{ ";c", commands, mode = "n", desc = "Telescope: Search [C]ommands" },
		{ ";d", file_browser, mode = "n", desc = "Telescope: [D]irectory & File Browser" },
		{ ";e", diagnostics, mode = "n", desc = "Telescope: Search diagnostics ([E]rrors)" },
		{ ";f", find_files, mode = "n", desc = "Telescope: Search [F]iles" },
		{ ";g", live_grep, mode = "n", desc = "Telescope: Live [G]rep" },
		{ ";h", help_tags, mode = "n", desc = "Telescope: Search [H]elps" },
		{ ";k", keymaps, mode = "n", desc = "Telescope: Search [K]eymaps" },
		{ ";m", harpoon, mode = "n", desc = "Telescope: Search Harpoon [M]arks" },
		{ ";o", oldfiles, mode = "n", desc = "Telescope: Search [O]ldfiles" },
		{ ";sd", document_symbols, mode = "n", desc = "Telescope: [S]ymbols in [D]ocument" },
		{ ";sw", workspace_symbols, mode = "n", desc = "Telescope: [S]ymbols in  [W]orkspace" },
		{ "gi", implementations, mode = "n", desc = "LSP: [G]oto [I]mplementations" },
		{ "gr", references, mode = "n", desc = "LSP: [G]oto [R]eferences" },
		{ "gt", type_definitions, mode = "n", desc = "LSP: [G]oto [T]ype definitions" },
	},
	config = function()
		local actions = require("telescope.actions")
		local fb_actions = require("telescope").extensions.file_browser.actions

		t().setup({
			defaults = {
				buffer_previewer_maker = new_preview_maker(100000),
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
			vimgrep_arguments = { "rg", "-L", "--vimgrep" },
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
