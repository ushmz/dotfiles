local function dap_config()
	local dap, dapui = require("dap"), require("dapui")

	local sign = vim.fn.sign_define
	sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
	sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
	sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })

	for _, language in ipairs({ "typescript", "javascript", "typescriptreact" }) do
		dap.configurations[language] = {
			{
				type = "pwa-node",
				request = "launch",
				name = "Launch file",
				program = "${file}",
				cwd = "${workspaceFolder}",
			},
			{
				type = "pwa-node",
				request = "attach",
				name = "Attach",
				processId = require("dap.utils").pick_process,
				cwd = "${workspaceFolder}",
			},
			{
				type = "pwa-node",
				request = "launch",
				name = "Debug Jest Tests",
				-- trace = true, -- include debugger info
				runtimeExecutable = "node",
				runtimeArgs = {
					"CI=true",
					"NODE_OPTIONS --dns-result-order=ipv4first --max_old_space_size=6144",
					"./node_modules/jest/bin/jest.js",
					"--runInBand",
				},
				rootPath = "${workspaceFolder}",
				cwd = "${workspaceFolder}",
				console = "integratedTerminal",
				internalConsoleOptions = "neverOpen",
			},
		}
	end

	-- NOTE:
	local bin = vim.fn.stdpath("data") .. "/nvim/mason/packages/js-debug-adapter"

	dap.listeners.before.attach.dapui_config = function()
		dapui.open()
	end

	dap.listeners.before.launch.dapui_config = function()
		dapui.open()
	end

	dap.listeners.before.event_terminated.dapui_config = function()
		dapui.close()
	end

	dap.listeners.before.event_exited.dapui_config = function()
		dapui.close()
	end

	---@diagnostic disable-next-line: missing-fields
	dapui.setup({ floating = { border = "rounded" } })
end

local function dap_ui()
	require("dapui").setup()
end

return {
	"rcarriga/nvim-dap-ui",
	event = { "VeryLazy" },
	dependencies = {
		{ "mfussenegger/nvim-dap", event = { "VeryLazy" }, config = dap_config },
		{ "nvim-neotest/nvim-nio", event = { "VeryLazy" } },
		-- {
		-- 	"microsoft/vscode-js-debug",
		-- 	build = "npm install --legacy-peer-deps && npm run compile",
		-- },
	},
	keys = {
		{
			"<leader>uo",
			function()
				require("dapui").open()
			end,
			mode = "n",
			desc = "dapui: Open DAP UI",
		},
		{
			"<leader>uc",
			function()
				require("dapui").close()
			end,
			mode = "n",
			desc = "dapui: Close DAP UI",
		},
		{
			"<leader>ut",
			function()
				require("dapui").toggle()
			end,
			mode = "n",
			desc = "dapui: Toggle DAP UI",
		},
	},
	config = dap_ui,
}
