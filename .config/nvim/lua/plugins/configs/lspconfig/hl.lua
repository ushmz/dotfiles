local M = {}

---Set diagnostic highlight colors
M.set = function()
	local theme = require("plugins.utils").theme
	local set_hl = require("plugins.utils").set_hl

	set_hl("DiagnosticError", { fg = theme.red })
	set_hl("DiagnosticWarn", { fg = theme.yellow })
	set_hl("DiagnosticHint", { fg = theme.cyan })
	set_hl("DiagnosticInfo", { fg = theme.green })
end

return M
