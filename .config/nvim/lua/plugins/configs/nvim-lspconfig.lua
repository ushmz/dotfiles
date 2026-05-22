local function config()
  -- To apply the default configurations for the server doesn't configure by lspconfig
  -- e.g. formatter, linter, etc.
  vim.diagnostic.config({
    underline = true,
    float = {
      source = "if_many",
      format = function(diagnostic)
        if diagnostic.code then
          return string.format("%s (%s: %s)", diagnostic.message, diagnostic.source, diagnostic.code)
        else
          return string.format("%s (%ss)", diagnostic.message, diagnostic.source)
        end
      end,
      header = {},
    },
    severity_sort = true,
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = "",
        [vim.diagnostic.severity.WARN] = " ",
        [vim.diagnostic.severity.HINT] = "",
        [vim.diagnostic.severity.INFO] = "",
      },
    },
    virtual_text = false,
    -- virtual_lines = {
    --   current_line = true,
    -- },
    update_in_insert = true,
  })

  vim.lsp.config("*", {
    ---@param client vim.lsp.Client
    ---@param bufnr number
    on_attach = function(client, bufnr)
      vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
      -- NOTE: To use fuzzy finder instead of quickfix list
      -- other keymaps like GoToImplementation, GoToReferences are set in telescope.nvim config
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "LSP: [G]oto [D]efinition" })
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "LSP: [G]oto [D]eclaration" })

      if client:supports_method("textDocument/formatting") then
        vim.keymap.set("n", "==", function()
          vim.lsp.buf.format({ bufnr = bufnr, timeout_ms = 5000 })
        end, { buffer = bufnr, desc = "LSP: Document formatting" })

        local fmtag = vim.api.nvim_create_augroup("LspDocumentFormatting", {})
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          group = fmtag,
          callback = function()
            vim.lsp.buf.format({ bufnr = bufnr, timeout_ms = 5000 })
          end,
        })
      end
    end,
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
  })
end

return {
  {
    "neovim/nvim-lspconfig",
    pin = true,
    commit = "8e2084bf5e40c79c1f42210a6ef96a0a4793a763",
    ft = { "*" },
    dependencies = {
      { "folke/lazydev.nvim", pin = true, commit = "ff2cbcba459b637ec3fd165a2be59b7bbaeedf0d", ft = { "lua" } },
      { "hrsh7th/cmp-nvim-lsp", pin = true, commit = "cbc7b02bb99fae35cb42f514762b89b5126651ef", ft = { "*" } },
      { "mason-org/mason-lspconfig.nvim", pin = true, commit = "25f609e7fca78af7cede4f9fa3af8a94b1c4950b" },
    },
    config = config,
  },
}
