---@type vim.lsp.Config
return {
  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false

    -- NOTE: To use fuzzy finder instead of quickfix list
    -- other keymaps like GoToImplementation, GoToReferences are set in telescope.nvim config
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "LSP: [G]oto [D]efinition" })
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "LSP: [G]oto [D]eclaration" })
  end,
  root_dir = function(bufnr, cb)
    -- Only run when vtsls is the selected server (see utils.ts_server).
    if require("utils").ts_server(bufnr) ~= "vtsls" then
      cb(nil)
      return
    end
    -- Single monorepo root: one instance for the whole workspace so warm-up can
    -- make find-references span packages.
    cb(vim.fs.root(bufnr, { "turbo.json", "turbo.jsonc", "pnpm-workspace.yaml", ".git" }))
  end,
  -- Without this, `cb(nil)` above (tsgo owns the buffer, or no root found) would
  -- still start vtsls in single-file mode, so both servers would attach.
  workspace_required = true,
  settings = {
    vtsls = {
      autoUseWorkspaceTsdk = true,
    },
    typescript = {
      preferences = {
        preferGoToSourceDefinition = true,
      },
      tsserver = {
        maxTsServerMemory = 8 * 1024,
        experimental = {
          enableProjectDiagnostics = true,
          disableReferencedProjectLoad = false,
        },
      },
    },
    javascript = {
      preferences = {
        preferGoToSourceDefinition = true,
      },
    },
  },
}
