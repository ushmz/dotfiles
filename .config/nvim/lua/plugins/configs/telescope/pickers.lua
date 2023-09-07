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

function M.buffers()
	b().buffers({})
end

function M.commands()
	b().commands({})
end

function M.diagnostics()
	b().diagnostics({})
end

function M.help_tags()
	b().help_tags({})
end

function M.keymaps()
	b().keymaps({})
end

function M.oldfiles()
	local entry_maker = require("plugins.configs.telescope.entry_maker")
	b().oldfiles({
		entry_maker = entry_maker.create_for_old_files(),
		layout_config = {
			preview_width = 0.4,
		},
	})
end

function M.resume()
	b().resume({})
end

function M.references()
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

function M.implementations()
	local entry_maker = require("plugins.configs.telescope.entry_maker")
	b().lsp_implementations({
		entry_maker = entry_maker.create_for_lsp_implementations(),
		layout_config = {
			preview_width = 0.4,
		},
	})
end

function M.type_definitions()
	b().lsp_type_definitions({
		include_declaration = false,
		include_current_line = false,
		layout_config = {
			preview_width = 0.4,
		},
	})
end

function M.document_symbols()
	b().lsp_document_symbols({})
end

function M.workspace_symbols()
	b().lsp_dynamic_workspace_symbols({})
end

function M.find_files()
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

function M.grep_string()
	local entry_maker = require("plugins.configs.telescope.entry_maker")
	local opts = { entry_maker = entry_maker.create_for_live_grep() }
	if is_git_repo() then
		opts["cwd"] = get_git_root()
	end
	b().grep_string(opts)
end

function M.live_grep()
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

function M.file_browser()
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

function M.harpoon()
	t().load_extension("harpoon")
	vim.cmd("Telescope harpoon marks")
end

return M
