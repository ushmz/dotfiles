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
  pin = true,
  commit = "f5b6673f374626515401c5bc51b005f784a4f252",
  event = { "VeryLazy" },
  dependencies = {
    { "mfussenegger/nvim-dap", pin = true, commit = "4f5deb110d9ff8994d96c21df95e2271d11214f9", event = { "VeryLazy" }, config = dap_config },
    -- { "suketa/nvim-dap-ruby" },
    { "nvim-neotest/nvim-nio", pin = true, commit = "21f5324bfac14e22ba26553caf69ec76ae8a7662", event = { "VeryLazy" } },
  },
  config = dap_ui,
}
