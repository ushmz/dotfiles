local function dap_config()
  local dap = require("dap")

  local ruby_adapter = require("plugins.configs.nvim-dap.ruby")
  dap.adapters.ruby = ruby_adapter.adapter
  dap.configurations.ruby = ruby_adapter.configurations

  local js_filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" }

  local vscode = require("dap.ext.vscode")
  vscode.type_to_filetypes["node"] = js_filetypes
  vscode.type_to_filetypes["pwa-node"] = js_filetypes

  local typescript_adapter = require("plugins.configs.nvim-dap.typescript")
  dap.adapters["pwa-node"] = typescript_adapter.pwa_node_adapter
  dap.adapters["node"] = typescript_adapter.node_adapter
  for _, ft in ipairs(js_filetypes) do
    dap.configurations[ft] = typescript_adapter.configurations[ft]
  end

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
    -- { "suketa/nvim-dap-ruby" },
    { "nvim-neotest/nvim-nio", event = { "VeryLazy" } },
  },
  config = dap_ui,
}
