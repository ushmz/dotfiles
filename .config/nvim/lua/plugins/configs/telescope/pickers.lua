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
	b().keymaps({ show_plug = false })
end

function M.oldfiles()
	local entry_maker = require("plugins.configs.telescope.entry_maker")
	b().oldfiles({
		entry_maker = entry_maker.old_files(),
		layout_config = {
			prompt_position = "top",
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
		entry_maker = entry_maker.lsp_references(),
		layout_config = {
			prompt_position = "top",
		},
	})
end

function M.implementations()
	local entry_maker = require("plugins.configs.telescope.entry_maker")
	b().lsp_implementations({
		entry_maker = entry_maker.lsp_implementations(),
		layout_config = {
			prompt_position = "top",
		},
	})
end

function M.type_definitions()
	b().lsp_type_definitions({
		include_declaration = false,
		include_current_line = false,
		layout_config = {
			prompt_position = "top",
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
		entry_maker = entry_maker.find_files(),
		layout_config = {
			prompt_position = "top",
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
	local opts = {
		vimgrep_arguments = {
			"rg",
			"--vimgrep",
			"--smart-case",
			"--hidden",
			"--trim",
			"--glob",
			"!.git",
			-- "--json",
		},
		entry_maker = entry_maker.live_grep(),
	}
	if is_git_repo() then
		opts["cwd"] = get_git_root()
	end
	b().grep_string(opts)
end

local function pretty_live_grep(opts)
	local configs = require("telescope.config").values
	return require("telescope.pickers").new(opts, {
		prompt_title = "Live Grep",
		finder = require("telescope.finders").new_job(function(prompt)
			if not prompt or prompt == "" then
				return nil
			end
			return vim.tbl_flatten({ opts.vimgrep_arguments, "--", prompt })
		end, opts.entry_maker, opts.max_results, opts.cwd),
		-- ascending has title "before" matches
		default_selection_index = 2,
		previewer = configs.grep_previewer(opts),
		sorter = require("telescope.sorters").new({
			scoring_function = function()
				return 0
			end,
		}),
		tiebreak = function(current, existing)
			if current.filename == existing.filename then
				if existing.kind == "begin" then
					return false
				else
					if existing.lnum < current.lnum then
						return false
					else
						return true
					end
				end
			end
		end,
	})
end

function M.live_grep()
	local cwd = is_git_repo() and get_git_root() or vim.loop.cwd()
	local entries = require("plugins.configs.telescope.entry_maker")
	local opts = {
		cwd = cwd,
		vimgrep_arguments = {
			"rg",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
			"--hidden",
			"--trim",
			"--glob",
			"!.git",
			"--json",
		},
		entry_maker = entries.pretty_live_grep({ cwd = cwd or "" }),
		layout_config = {
			prompt_position = "top",
		},
		attach_mappings = function(_)
			local keys = {
				"move_selection_next",
				"move_selection_previous",
				"move_selection_better",
				"move_selection_worse",
			}
			for _, key in ipairs(keys) do
				local action = require("telescope.actions")[key]
				action:enhance({
					post = function(bufnr)
						local entry = require("telescope.actions.state").get_selected_entry()
						if entry and entry.kind == "begin" then
							-- repeat the action to skip the "begin" entry
							action(bufnr)
						end
					end,
				})
			end
			return true
		end,
	}
	pretty_live_grep(opts):find()
end

function M.egrepify()
	t().load_extension("egrepify")
	t().extensions["egrepify"]["egrepify"]({
		layout_config = {
			prompt_position = "top",
		},
	})
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

return M
