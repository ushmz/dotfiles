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
    -- Prefer the nearest package/config root so each workspace package resolves its own tsconfig.
    local package_root = vim.fs.root(bufnr, { "tsconfig.json", "jsconfig.json", "package.json" })
    if package_root then
      cb(package_root)
      return
    end

    -- Fallback to monorepo root.
    local monorepo_root = vim.fs.root(bufnr, { "turbo.json", "turbo.jsonc", "pnpm-workspace.yaml", ".git" })
    if monorepo_root then
      cb(monorepo_root)
      return
    end

    cb(nil)
  end,
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
      },
    },
    javascript = {
      preferences = {
        preferGoToSourceDefinition = true,
      },
    },
  },
}
