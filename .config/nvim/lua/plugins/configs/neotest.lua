local function test_nearest(strategy)
	local opt = {}
	if strategy then
		opt[strategy] = "dap"
	end
	require("neotest").run.run(opt)
end

local function test_file(file, strategy)
	local opt = { file or vim.fn.expand("%") }
	if strategy then
		opt[strategy] = "dap"
	end
	require("neotest").run.run(opt)
end

local function test_directory(directory, strategy)
	local opt = { directory or vim.fn.fnamemodify(vim.fn.expand("%"), ":h") }
	if strategy then
		opt[strategy] = "dap"
	end
	require("neotest").run.run(opt)
end

local function test_suite(project_root, strategy)
	local opt = { project_root or vim.fn.getcwd() }
	if strategy then
		opt[strategy] = "dap"
	end
	-- vim.inspect(require("neotest").run)
	require("neotest").run.run(opt)
end

local function test_stop()
	require("neotest").run.stop()
end

local function test_attach()
	require("neotest").run.attach()
end

local function python_adapter()
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

local function plenary_adapter()
	return require("neotest-plenary").setup({
		---By default, it will glob for:
		---{ "*/testrc*", "*/minimal_init*", "test*/init.vim" }
		-- min_init = "./path/to/test_init.lua",
	})
end

local function go_adapter()
	return require("neotest-go")({
		experimental = { test_table = true },
		args = { "-count=1", "-timeout=60s" },
	})
end

local function jest_adapter()
	return require("neotest-jest")({
		jestCommand = "npm test --",
		jestConfigFile = "custom.jest.config.ts",
		env = { CI = true },
		cwd = function(path)
			return vim.fn.getcwd()
		end,
	})
end

local function playwright_adapter()
	return require("neotest-playwright").adapter({
		options = {
			persist_project_selection = true,
			enable_dynamic_test_discovery = true,
		},
	})
end

local function set_hl()
	vim.api.nvim_set_hl(0, "NeotestPassed", { fg = "#B5BD68" })
	vim.api.nvim_set_hl(0, "NeotestFailed", { fg = "#CC6666" })
	vim.api.nvim_set_hl(0, "NeotestRunning", { fg = "#F0C674" })
	vim.api.nvim_set_hl(0, "NeotestSkipped", { fg = "#81A2BE" })
	vim.api.nvim_set_hl(0, "NeotestFile", { fg = "#81A2BE" })
	vim.api.nvim_set_hl(0, "NeotestDir", { fg = "#8ABEB7" })
	vim.api.nvim_set_hl(0, "NeotestNamespace", { fg = "#B5BD68" })
	vim.api.nvim_set_hl(0, "NeotestFocused", { bold = true, underline = true })
	vim.api.nvim_set_hl(0, "NeotestIndent", { fg = "#808080" })
	vim.api.nvim_set_hl(0, "NeotestExpandMarker", { fg = "#81A2BE" })
	vim.api.nvim_set_hl(0, "NeotestAdapterName", { fg = "#CC6666" })
	vim.api.nvim_set_hl(0, "NeotestWinSelect", { fg = "#8aBEB7", bold = true })
	vim.api.nvim_set_hl(0, "NeotestMarked", { fg = "#F0C674", bold = true })
	vim.api.nvim_set_hl(0, "NeotestTarget", { fg = "#CC6666" })
	vim.api.nvim_set_hl(0, "NeotestTest", { fg = "#D4D4D4" })
end

local function config()
	-- require("neodev").setup({
	-- 	library = { plugins = { "neotest" }, types = true },
	-- })
	require("neotest").setup({
		-- [TODO] Can load depends on current filetype?
		adapters = {
			plenary_adapter(),
			go_adapter(),
			jest_adapter(),
			playwright_adapter(),
		},
	})
	set_hl()
end

return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			---@see https://github.com/antoinemadec/FixCursorHold.nvim/issues/13
			"antoinemadec/FixCursorHold.nvim",
			{
				"nvim-neotest/neotest-python", --[[ ft = { "python" } ]]
			},
			{
				"nvim-neotest/neotest-plenary", -- [[ ft = { "lua" } ]]
			},
			{
				"nvim-neotest/neotest-go", -- [[ ft = { "go" } ]]
			},
			{
				"nvim-neotest/neotest-jest",
				-- ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" }
			},
			{
				"thenbe/neotest-playwright",
				-- ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" }
			},
		},
		keys = {
			{ "tn", test_nearest, mode = "n", desc = "Neotest: Run the [N]earest test" },
			{ "tb", test_file, mode = "n", desc = "Neotest: Run test for a file on current [B]uffer" },
			{ "td", test_directory, mode = "n", desc = "Neotest: Run [T]est for current [D]irectory" },
			{ "tt", test_suite, mode = "n", desc = "Neotest: Run full [T]est suite" },
			{ "tq", test_stop, mode = "n", desc = "Neotest: [S]top running test" },
			{ "ta", test_attach, mode = "n", desc = "Neotest: [A]ttach to the nearest test" },
			{
				"to",
				function()
					require("neotest").output_panel.toggle({})
				end,
				mode = "n",
				desc = "Neotest: Toggle [O]utput",
			},
			{
				"ts",
				function()
					require("neotest").summary.toggle()
				end,
				mode = "n",
				desc = "Neotest: Toggle [S]ummary",
			},
			-- { "<leader>tw", test_file, mode = "n", desc = "neotest: Run [T]est in watch mode" },
			-- [TODO] Debug
			-- { "<leader>tn", test_function, mode = "n", desc = "Neotest: Run the nearest [T]est" },
			-- { "<leader>tb", test_file, mode = "n", desc = "Neotest: Run [T]est for a file on current [B]uffer" },
			-- { "<leader>td", test_directory, mode = "n", desc = "Neotest: Run [T]est for current [D]irectory" },
			-- { "<leader>tt", test_suite, mode = "n", desc = "Neotest: Run full [T]est suite" },
		},
		config = function()
			vim.keymap.set("n", "t", "<Nop>")
			config()
		end,
	},
}
