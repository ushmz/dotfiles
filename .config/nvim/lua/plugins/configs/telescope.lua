local ok, telescope = pcall(require, "telescope")
if not ok then
	return
end

local actions = require("telescope.actions")
local previewers = require("telescope.previewers")
local previewers_utils = require("telescope.previewers.utils")

local fb_actions = telescope.extensions.file_browser.actions

local max_size = 100000
--- Ignore files bigger than a threshold
local function new_maker(filepath, bufnr, opts)
	opts = opts or {}
	filepath = vim.fn.expand(filepath)
	vim.loop.fs_stat(filepath, function(_, stat)
		if not stat then
			return
		end
		if stat.size > max_size then
			local cmd = { "head", "-c", max_size, filepath }
			previewers_utils.job_maker(cmd, bufnr, opts)
		else
			previewers.buffer_previewer_maker(filepath, bufnr, opts)
		end
	end)
end

telescope.setup({
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
