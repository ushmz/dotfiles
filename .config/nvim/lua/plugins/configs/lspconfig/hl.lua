local M = {}

---Set diagnostic highlight colors
M.set = function()
	local theme = require("plugins.utils").theme
	local set_hl = require("plugins.utils").set_hl

	set_hl("DiagnosticError", { fg = theme.red })
	set_hl("DiagnosticWarn", { fg = theme.yellow })
	set_hl("DiagnosticHint", { fg = theme.cyan })
	set_hl("DiagnosticInfo", { fg = theme.green })

	local signs = { Error = "", Warn = " ", Hint = "", Info = "" }
	for type, icon in pairs(signs) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
	end
end

return M
