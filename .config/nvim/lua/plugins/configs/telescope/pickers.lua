local M = {}

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

M.buffers = function()
	b().buffers({})
end

M.commands = function()
	b().commands({})
end

M.diagnostics = function()
	b().diagnostics({})
end

M.help_tags = function()
	b().help_tags({})
end

M.keymaps = function()
	b().keymaps({ show_plug = false })
end

M.oldfiles = function()
	local entry_maker = require("plugins.configs.telescope.entry_maker")
	b().oldfiles({
		entry_maker = entry_maker.create_for_old_files(),
		layout_config = {
			preview_width = 0.4,
		},
	})
end

M.resume = function()
	b().resume({})
end

M.references = function()
	local entry_maker = require("plugins.configs.telescope.entry_maker")
	b().lsp_references({
		include_declaration = false,
		include_current_line = false,
		entry_maker = entry_maker.create_for_lsp_references(),
		layout_config = {
			preview_width = 0.4,
		},
	})
end

M.implementations = function()
	local entry_maker = require("plugins.configs.telescope.entry_maker")
	b().lsp_implementations({
		entry_maker = entry_maker.create_for_lsp_implementations(),
		layout_config = {
			preview_width = 0.4,
		},
	})
end

M.type_definitions = function()
	b().lsp_type_definitions({
		include_declaration = false,
		include_current_line = false,
		layout_config = {
			preview_width = 0.4,
		},
	})
end

M.document_symbols = function()
	b().lsp_document_symbols({})
end

M.workspace_symbols = function()
	b().lsp_dynamic_workspace_symbols({})
end

M.find_files = function()
	local entry_maker = require("plugins.configs.telescope.entry_maker")
	local opts = {
		no_ignore = false,
		hidden = true,
		entry_maker = entry_maker.create_for_find_files(),
		layout_config = {
			preview_width = 0.4,
		},
	}
	if is_git_repo() then
		b().git_files(opts)
	else
		b().find_files(opts)
	end
end

M.grep_string = function()
	local entry_maker = require("plugins.configs.telescope.entry_maker")
	local opts = { entry_maker = entry_maker.create_for_live_grep() }
	if is_git_repo() then
		opts["cwd"] = get_git_root()
	end
	b().grep_string(opts)
end

M.live_grep = function()
	local entries = require("plugins.configs.telescope.entry_maker")
	local opts = {
		-- NOTE: To add `--hidden` option to `telescope.defaults.vimgrep_arguments` is not working.
		--       So, I use `additional_args` option instead.
		additional_args = { "--hidden", "--glob", "!.git" },
		entry_maker = entries.create_for_live_grep(),
		layout_config = {
			preview_width = 0.4,
		},
	}
	if is_git_repo() then
		opts["cwd"] = get_git_root()
	end
	b().live_grep(opts)
end

M.file_browser = function()
	t().load_extension("file_browser")
	t().extensions["file_browser"]["file_browser"]({
		cwd = vim.fn.expand("%:p:h"),
		respect_gitignore = false,
		hidden = true,
		grouped = true,
		previewer = false,
		initial_mode = "normal",
		layout_config = { height = 40, width = 100 },
	})
end

M.harpoon = function()
	t().load_extension("harpoon")
	vim.cmd("Telescope harpoon marks")
end

return M
