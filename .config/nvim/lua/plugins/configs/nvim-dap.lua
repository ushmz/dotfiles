local function dap_config()
	-- require("dap").setup({})
	local sign = vim.fn.sign_define
	sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
	sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
	sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })
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
	},
	config = dap_ui,
}
