---@type vim.lsp.Config
return {
  cmd = function(dispatchers, config)
    -- `root_dir` is the directory that owns `node_modules/tsgo`.
    local bin = require("utils").tsgo_bin_from(config.root_dir)
    return vim.lsp.rpc.start({ bin, "--lsp", "--stdio" }, dispatchers)
  end,
  root_dir = function(bufnr, cb)
    local utils = require("utils")
    -- Only run when tsgo is the selected server (see utils.ts_server).
    if utils.ts_server(bufnr) ~= "tsgo" then
      cb(nil)
      return
    end
    -- Single workspace root (the directory that owns `node_modules/tsgo`); tsgo
    -- resolves each package's tsconfig internally -- one instance per monorepo.
    local _, owner = utils.tsgo_bin(bufnr)
    cb(owner)
  end,
  -- Do not fall back to single-file mode when no root is found, otherwise `cmd`
  -- would be invoked with a nil `root_dir` in repos without tsgo.
  workspace_required = true,
  filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
}
