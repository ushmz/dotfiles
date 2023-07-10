local function config()
	local util = require("formatter.util")
	require("formatter").setup({
		logging = true,
		log_level = vim.log.levels.WARN,
		-- Formatter configurations will be executed in order
		filetype = {
			css = { require("formatter.filetypes.css").stylefmt },
			dart = { require("formatter.filetypes.dart").dartfmt },
			go = {
				require("formatter.filetypes.go").gofmt,
				require("formatter.filetypes.go").goimports,
			},
			html = { require("formatter.filetypes.html").prettier },
			javascript = {
				require("formatter.filetypes.javascript").prettier,
				require("formatter.filetypes.javascript").eslint_d,
			},
			javascriptreact = {
				require("formatter.filetypes.javascript").prettier,
				require("formatter.filetypes.javascript").eslint_d,
			},
			json = { require("formatter.filetypes.json").prettier },
			lua = { require("formatter.filetypes.lua").stylua },
			markdown = { require("formatter.filetypes.markdown").prettier },
			python = { require("formatter.filetypes.python").black },
			rust = { require("formatter.filetypes.rust").rustfmt },
			sh = { require("formatter.filetypes.sh").shfmt },
			sql = { require("formatter.filetypes.sql").pgformat },
			-- toml = { require("formatter.filetypes.toml").taplo },
			typescript = {
				require("formatter.filetypes.javascript").prettier,
				require("formatter.filetypes.javascript").eslint_d,
			},
			typescriptreact = {
				require("formatter.filetypes.javascript").prettier,
				require("formatter.filetypes.javascript").eslint_d,
			},
			yaml = { require("formatter.filetypes.yaml").yamlfmt },
			["*"] = {
				require("formatter.filetypes.any").remove_trailing_whitespace,
			},
		},
	})

	vim.keymap.set("n", "<leader>f", "<cmd>Format<CR>", { noremap = true, silent = true })
	vim.api.nvim_create_autocmd("BufWritePre", {
		callback = function()
			vim.cmd("Format")
		end,
	})
end

return {
	"mhartington/formatter.nvim",
	event = { "BufNewFile", "BufReadPre", "FileReadPre" },
	config = config,
}
