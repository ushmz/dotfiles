vim.cmd("autocmd!")

require("basics")

if vim.g.vscode then
  require("basics.vscode")
  require("mappings.vscode")
  return
end

require("mappings")
require("filetypes")
require("plugins")

-- Auto switch IME
if jit and jit.os == "OSX" then
	if vim.fn.executable("im-select") then
		vim.api.nvim_create_autocmd("FocusGained", {
			pattern = { "*" },
			callback = function()
				if vim.fn.mode() == "i" then
					return
				end
				vim.fn.system({ "im-select", "com.apple.keylayout.ABC" })
			end,
		})

		vim.api.nvim_create_autocmd({ "InsertLeave", "VimEnter" }, {
			pattern = { "*" },
			callback = function()
				vim.fn.system({ "im-select", "com.apple.keylayout.ABC" })
			end,
		})
	end
end

-- HACK: Run some Ex commands after loading configs & plugins
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		if vim.g.review then
			local pn = tonumber(vim.g.review)
			if not pn then
				vim.api.nvim_err_writeln("Invalid PR number: " .. vim.g.review)
				return
			end
			vim.cmd(":Octo pr edit" .. vim.g.review)
		end
	end,
})
