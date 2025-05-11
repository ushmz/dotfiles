---@type vim.lsp.Config
return {
	settings = {
		Lua = {
			diagnostics = { globals = { "vim" } },
			telemetry = { enable = false },
			runtime = {
				version = "LuaJIT",
				pathStrict = true,
				path = { "?.lua", "?/init.lua" },
			},
			workspace = {
				library = vim.list_extend(vim.api.nvim_get_runtime_file("lua", true), {
					vim.fn.stdpath("config") .. "/lua",
					-- vim.fn.*, vim.api.*
					vim.env.VIMRUNTIME .. "/lua",
					-- vim.uv.*, (vim.loop.*)
					"${3rd}/luv/library",
					"${3rd}/busted/library",
					"${3rd}/luaassert/library",
				}),
				checkThirdParty = false,
			},
		},
	},
}
