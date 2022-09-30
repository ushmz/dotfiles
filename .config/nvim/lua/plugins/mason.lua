local status1, mason = pcall(require, 'mason')
if (not status1) then return end

local status2, lspconfig = pcall(require, 'mason-lspconfig')
if (not status2) then return end

mason.setup({
  ui = {
    icons = {
      package_installed = '✓',
      package_pending = '➜',
      package_uninstalled = '✗'
    }
  }
})

lspconfig.setup({
  ensure_installed = {
    -- LSP
    'bash-language-server',
    'css-lsp',
    'dockerfile-language-server',
    'eslint-lsp',
    'gopls',
    'html-lsp',
    'json-lsp',
    'kotlin-language-server',
    'lua-language-server',
    'prisma-language-server',
    'pyright',
    'sqls',
    'stylelint-lsp',
    'tailwindcss-language-server',
    'typescript-language-server',
    'yaml-language-server',
    -- Linter
    'flake8',
    'golangci-lint',
    'ktlint',
    'markdownlint',
    -- Formatter
    'black',
    'goimports',
    'prettier',
    'rust-analyzer',
    'shfmt',
    'sql-formatter',
  }
})
