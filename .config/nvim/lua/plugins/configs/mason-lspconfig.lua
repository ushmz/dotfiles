return {
  "mason-org/mason-lspconfig.nvim",
  pin = true,
  commit = "25f609e7fca78af7cede4f9fa3af8a94b1c4950b",
  lazy = true,
  dependencies = {
    { "mason-org/mason.nvim", pin = true, commit = "44d1e90e1f66e077268191e3ee9d2ac97cc18e65" },
  },
  config = function()
    local servers = {
      -- cSpell:disable
      "bashls",
      "dockerls",
      "eslint",
      "gopls",
      "html",
      "jsonls",
      "kotlin_language_server",
      "lua_ls",
      "pyright",
      "ruff",
      "rubocop",
      "rust_analyzer",
      "ruby_lsp",
      "sqlls",
      "tailwindcss",
      "vtsls",
      -- cSpell:enable
    }

    require("mason-lspconfig").setup({
      automatic_enable = true,
      ensure_installed = jit.os == "OSX" and servers or {},
    })
    -- Manually install like this
    -- FYI: 'WhoIsSethDaniel/mason-tool-installer.nvim'
    -- vim.cmd([[
    --   MasonInstall cspell dockerfile-language-server goimports html-lsp markdownlint
    --    \ prettier rustfmt shfmt
    --    \ yaml-language-server yamlfmt yamllint
    --   ]])
    --
    -- You should also install the dictionaries for cspell
    -- vim.cmd([[
    --  !npm install -g ...
    -- ]])
  end,
}
