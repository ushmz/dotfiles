if not vim.g.vscode then
	return
end

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }
local action = function(cmd, opts)
	return function()
		require("vscode").action(cmd, opts)
	end
end

keymap("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

keymap({ "n" }, "<leader>w", action("workbench.action.files.save", opts))
keymap({ "n" }, "<leader>q", action("workbench.action.closeActiveEditor", opts))
keymap({ "n", "x" }, "gh", "g^")
keymap({ "n", "x" }, "gl", "g$")
keymap({ "n" }, "<leader><leader>", action("workbench.action.toggleZenMode", opts))
keymap({ "n" }, "gn", action("editor.action.marker.nextInFiles", opts))
keymap({ "n" }, "gN", action("editor.action.marker.prevInFiles", opts))
keymap(
	{ "n" },
	"gf",
	action("workbench.action.quickOpen", vim.tbl_extend("force", opts, { args = { query = vim.fn.expand("<cword>") } }))
)
keymap({ "n" }, "ygf", action("workbench.action.files.copyPathOfActiveFile", opts))

-- tabs & panes
keymap("n", "<C-w>w", action("workbench.action.navigateEditorGroups", opts))
keymap("n", "<C-w>h", action("workbench.action.focusLeftGroupWithoutWrap", opts))
keymap("n", "<C-w>j", action("workbench.action.focusBelowGroupWithoutWrap", opts))
keymap("n", "<C-w>k", action("workbench.action.focusAboveGroupWithoutWrap", opts))
keymap("n", "<C-w>l", action("workbench.action.focusRightGroupWithoutWrap", opts))
keymap("n", "<C-w>o", action("workbench.action.closeOtherEditors", opts))
keymap("n", "<C-w>s", action("workbench.action.splitEditorDown", opts))
keymap("n", "<C-w>v", action("workbench.action.splitEditorRight", opts))
keymap("n", "<C-w>,", action("workbench.action.previousEditor", opts))
keymap("n", "<C-w>.", action("workbench.action.nextEditor", opts))
keymap("n", "<C-w>/", action("workbench.action.togglePanel", opts))

-- Telescope.nvim equivalent
keymap({ "n" }, "<leader>d", action("workbench.view.explorer", opts))
keymap({ "n" }, "<leader>g", action("workbench.view.search", opts))
keymap({ "n" }, "<leader>f", action("workbench.action.quickOpen", opts))
keymap({ "n" }, "<leader>e", action("workbench.action.showErrorsWarnings", opts))
keymap({ "n" }, "<leader>k", action("workbench.action.openGlobalKeybindings", opts))

-- LSP related
keymap({ "n" }, "K", action("editor.action.showHover"), opts)
keymap({ "n" }, "gd", action("editor.action.revealDefinition", opts))
keymap({ "n" }, "gr", action("editor.action.goToReferences", opts))
keymap({ "n" }, "gi", action("editor.action.goToImplementation", opts))
keymap({ "n" }, "gt", action("editor.action.goToTypeDefinition", opts))
keymap({ "n" }, "gs", action("editor.action.goToSymbol", opts))
keymap({ "n" }, "gp", action("editor.action.peekDefinition", opts))
keymap({ "n" }, "<leader>r", action("editor.action.rename", opts))
keymap({ "n" }, "==", action("editor.action.formatDocument", opts))
keymap({ "n", "v" }, "<leader>a", action("editor.action.quickFix"), opts)
keymap("n", "<C-j>", action("editor.action.marker.nextInFiles", opts))
keymap("n", "<C-k>", action("editor.action.marker.prevInFiles", opts))