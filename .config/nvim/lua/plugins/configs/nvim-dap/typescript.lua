local M = {}

local base_config = {
  {
    type = "pwa-node",
    request = "launch",
    name = "Launch file",
    program = "${file}",
    cwd = "${workspaceFolder}",
    error_on_failure = true,
    localfs = true,
  },
  {
    type = "pwa-node",
    request = "attach",
    name = "Attach",
    processId = require("dap.utils").pick_process,
    cwd = "${workspaceFolder}",
    error_on_failure = true,
    localfs = true,
  },
}

M.pwa_node_adapter = {
  type = "server",
  host = "localhost",
  port = "${port}",
  executable = {
    command = "node",
    args = {
      os.getenv("HOME") .. "/.local/share/nvim/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
      "${port}",
    },
  },
}

M.node_adapter = function(cb, config)
  if config.type == "node" then
    config.type = "pwa-node"
  end

  local native_adapter = dap.adapters["pwa-node"]
  if type(native_adapter) == "function" then
    native_adapter(cb, config)
  else
    cb(native_adapter)
  end
end

M.configurations = {
  typescript = base_config,
  typescriptreact = base_config,
  javascript = base_config,
  javascriptreact = base_config,
}

M.adapter = function(callback, config) end

return M
