local adapters = require("plugins.configs.neotest.adapters")
local hl = require("plugins.configs.neotest.hl")

local function config()
	-- require("neodev").setup({
	-- 	library = { plugins = { "neotest" }, types = true },
	-- })
	require("neotest").setup({
		-- [TODO] Can load depends on current filetype?
		adapters = {
			adapters.plenary_adapter(),
			adapters.go_adapter(),
			adapters.jest_adapter(),
			adapters.playwright_adapter(),
		},
	})
	hl.set()
end

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
