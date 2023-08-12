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
	b().keymaps({})
end

M.oldfiles = function()
	b().oldfiles({})
end

M.resume = function()
	b().resume({})
end

M.references = function()
	local entry_maker = require("plugins.configs.telescope.entry_maker")
	b().lsp_references({
		include_declaration = false,
		include_current_line = false,
    entry_maker = entry_maker.create_for_lsp_references()
	})
end

M.implementations = function()
	b().lsp_implementations({})
end

M.type_definitions = function()
	b().lsp_type_definitions({})
end

M.document_symbols = function()
	b().lsp_document_symbols({})
end

M.workspace_symbols = function()
	b().lsp_dynamic_workspace_symbols({})
end

M.find_files = function()
	local entry_maker = require("plugins.configs.telescope.entry_maker")
	local opts = { no_ignore = false, hidden = true, entry_maker = entry_maker.create_for_find_files() }
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
		table.insert(opts, { cwd = get_git_root() })
	end
	b().grep_string(opts)
end

M.live_grep = function()
	local entries = require("plugins.configs.telescope.entry_maker")
	local opts = { entry_maker = entries.create_for_live_grep() }
	if is_git_repo() then
		table.insert(opts, { cwd = get_git_root() })
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
