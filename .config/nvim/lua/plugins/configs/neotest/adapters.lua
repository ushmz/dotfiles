local M = {}

M.python_adapter = function()
	return require("neotest-python")({
		-- 	---Extra arguments for nvim-dap configuration
		-- 	---See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
		-- 	dap = { justMyCode = false },
		-- 	---Command line arguments for runner
		-- 	---Can also be a function to return dynamic values
		-- 	args = { "--log-level", "DEBUG" },
		-- 	---Runner to use. Will use pytest if available by default.
		-- 	---@type string | function
		-- 	runner = "pytest",
		-- 	---Custom python path for the runner.
		-- 	---If not provided, the path will be inferred by checking for
		-- 	---virtual envs in the local directory and for Pipenev/Poetry configs
		-- 	---@type string | string[] | function
		-- 	-- python = ".venv/bin/python",
		-- 	---Returns if a given file path is a test file.
		-- 	---NB: This function is called a lot so don't perform any heavy tasks within it.
		-- 	-- is_test_file = function(file_path) end,
	})
end

M.plenary_adapter = function()
	return require("neotest-plenary").setup({
		---By default, it will glob for:
		---{ "*/testrc*", "*/minimal_init*", "test*/init.vim" }
		-- min_init = "./path/to/test_init.lua",
	})
end

M.go_adapter = function()
	return require("neotest-go")({
		experimental = { test_table = true },
		args = { "-count=1", "-timeout=60s" },
	})
end

M.jest_adapter = function()
	return require("neotest-jest")({
		jestCommand = "yarn test --runInBand",
		jestConfigFile = "jest.config.ts",
		jest_test_discovery = false,
		env = {
			CI = true,
			NODE_OPTIONS = "--dns-result-order=ipv4first",
		},
		cwd = function(_)
			return vim.fn.getcwd()
		end,
	})
end

M.playwright_adapter = function()
	return require("neotest-playwright").adapter({
		options = {
			persist_project_selection = true,
			enable_dynamic_test_discovery = true,
		},
	})
end

return M
