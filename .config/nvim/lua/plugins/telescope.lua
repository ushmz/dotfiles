---Plugin configs.
---@type { config: function, setup: function}
local M = {}

M.setup = function()
	---Return telescope builtin with option.
	---@param name string
	---@return function
	local function builtin(name)
		return function(opt)
			return function()
				return require("telescope.builtin")[name](opt or {})
			end
		end
	end

	---Return load_extension with option.
	---@param name string
	---@param prop string
	---@return function
	local function extensions(name, prop)
		return function(opt)
			return function()
				local t = require("telescope")
				t.load_extension(name)
				return t.extensions[name][prop](opt or {})
			end
		end
	end
	vim.keymap.set("n", ";b", builtin("buffers")({}))
	vim.keymap.set("n", ";c", builtin("commands")({}))
	vim.keymap.set("n", ";e", builtin("diagnostics")({}))
	vim.keymap.set("n", ";h", builtin("help_tags")({}))
	vim.keymap.set("n", ";k", builtin("keymaps")({}))
	vim.keymap.set("n", ";l", builtin("oldfiles")({}))
	vim.keymap.set("n", ";;", builtin("resume")({}))

	vim.keymap.set(
		"n",
		";f",
		builtin("find_files")({
			no_ignore = false,
			grouped = true,
			hidden = true,
		})
	)

	vim.keymap.set(
		"n",
		";g",
		builtin("live_grep")({
			no_ignore = false,
			hidden = true,
			grouped = true,
		})
	)

	vim.keymap.set(
		"n",
		";d",
		extensions("file_browser", "file_browser")({
			path = "%:p:h",
			cwd = vim.fn.expand("%:p:h"),
			respect_gitignore = false,
			hidden = true,
			grouped = true,
			previewer = false,
			initial_mode = "normal",
			layout_config = { height = 40 },
		})
	)
end

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
			require("telescope.previewers.utils").job_maker(cmd, bufnr, opts)
		else
			require("telescope.previewers").buffer_previewer_maker(filepath, bufnr, opts)
		end
	end)
end

M.config = function()
  local telescope = require("telescope")
	local actions = require("telescope.actions")
	local fb_actions = require("telescope").extensions.file_browser.actions

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
end

return M
