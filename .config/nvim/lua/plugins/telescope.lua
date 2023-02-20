local function t()
	return require("telescope")
end
local function b()
	return require("telescope.builtin")
end

local function buffers()
	b()["buffers"]({})
end

local function commands()
	b()["commands"]({})
end

local function diagnostics()
	b()["diagnostics"]({})
end

local function help_tags()
	b()["help_tags"]({})
end

local function keymaps()
	b()["keymaps"]({})
end

local function oldfiles()
	b()["oldfiles"]({})
end

local function resume()
	b()["resume"]({})
end

local function find_files()
	b()["find_files"]({
		no_ignore = false,
		grouped = true,
		hidden = true,
	})
end

local function live_grep()
	b()["live_grep"]({
		no_ignore = false,
		grouped = true,
		hidden = true,
	})
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

local max_size = 100000
--- Ignore files bigger than a threshold
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
		{ "nvim-telescope/telescope-file-browser.nvim" },
	},
	keys = {
		{ ";b", buffers, mode = "n", desc = "Search buffers" },
		{ ";c", commands, mode = "n", desc = "Search commands" },
		{ ";e", diagnostics, mode = "n", desc = "Search diagnostics" },
		{ ";h", help_tags, mode = "n", desc = "Search helps" },
		{ ";k", keymaps, mode = "n", desc = "Search keymaps" },
		{ ";l", oldfiles, mode = "n", desc = "Search oldfiles" },
		{ ";;", resume, mode = "n", desc = "Resume latest search" },
		{ ";f", find_files, mode = "n", desc = "Search files" },
		{ ";g", live_grep, mode = "n", desc = "Search keywords" },
		{ ";d", file_browser, mode = "n", desc = "File browser" },
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
