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
    -- tsgo (TypeScript 7 native) is a node_modules binary, not a mason package,
    -- so automatic_enable does not cover it. Its config lives in after/lsp/tsgo.lua
    -- (and vtsls defers to it in after/lsp/vtsls.lua); enable it explicitly.
    vim.lsp.enable("tsgo")

    -- tsgo/vtsls only search loaded projects for find-references, so warm up
    -- projects (via the local tsgo-warmup plugin) when whichever TS server is
    -- active attaches. Only one of tsgo/vtsls runs per buffer (utils.ts_server
    -- gates them). Defaults set here; overridable per-repo via the tsgo.warmup
    -- neoconf setting.
    require("tsgo-warmup").setup({ globs = { "packages/*/index.ts" } })
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and (client.name == "tsgo" or client.name == "vtsls") and client.config.root_dir then
          require("tsgo-warmup").run(client.config.root_dir)
        end
      end,
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
