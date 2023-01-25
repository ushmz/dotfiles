local function builtin(name)
	return function(opt)
		return function()
			return require("telescope.builtin")[name](opt or {})
		end
	end
end

local function extensions(name, prop)
	return function(opt)
		return function()
			local telescope = require("telescope")
			telescope.load_extension(name)
			return telescope.extensions[name][prop](opt or {})
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
