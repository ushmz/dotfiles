local function dap_config()
	-- require("dap").setup({})
end

local function dap_ui()
	require("dapui").setup()
end

return {
	"rcarriga/nvim-dap-ui",
	event = { "BufRead" },
	dependencies = {
		{ "mfussenegger/nvim-dap", config = dap_config },
	},
	config = dap_ui,
}
