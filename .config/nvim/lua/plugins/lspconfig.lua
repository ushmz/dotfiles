local status1, lsp = pcall(require, 'lspconfig')
if (not status1) then return end

local status2, ml = pcall(require, 'mason-lspconfig')
if (not status2) then return end


local signs = { Error = ' ', Warn = ' ', Hint = ' ', Info = ' ' }
for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
end

vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = true,
  float = {
    source = 'if_many',
  },
})

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics,
  {
    underline = true,
    update_in_insert = false,
    virtual_text = false,
    severity_sort = true,
  }
)

local on_attach = function(client, bufnr)
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  local opts = { noremap = true, silent = true }
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gr', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', 'gt', '<Cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', 'gi', '<Cmd>lua vim.lsp.buf.implementation()<CR>', opts)

  local fmt_fnstr = '<Cmd>lua vim.lsp.buf.format({bufnr = ' .. bufnr .. ', timeout_ms = 10000})<CR>'

  buf_set_keymap('n', '<leader>f', fmt_fnstr, opts)

  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_create_augroup('lsp_document_highlight', { clear = true })
    vim.api.nvim_clear_autocmds({ buffer = bufnr, group = "lsp_document_highlight" })
    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
      callback = vim.lsp.buf.document_highlight,
      buffer = bufnr,
      group = 'lsp_document_highlight',
    })
    vim.api.nvim_create_autocmd({ 'Cursormoved' }, {
      callback = vim.lsp.buf.clear_references,
      buffer = bufnr,
      group = 'lsp_document_highlight',
    })
    vim.api.nvim_set_hl(0, 'LspReferenceText', { ctermbg = 240, bg = '#515761' })
    vim.api.nvim_set_hl(0, 'LspReferenceRead', { ctermbg = 240, bg = '#515761' })
    vim.api.nvim_set_hl(0, 'LspReferenceWrite', { ctermbg = 240, bg = '#515761' })
  end
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local lsp_flags = {
  debounce_text_changes = 150,
}

ml.setup_handlers({
  function(server_name)
    lsp[server_name].setup({
      on_attach = on_attach,
      flags = lsp_flags,
      capabilities = capabilities,
    })
  end,
  ['sumneko_lua'] = function(_)
    lsp.sumneko_lua.setup {
      on_attach = on_attach,
      flags = lsp_flags,
      capabilities = capabilities,
      settings = {
        Lua = {
          diagnostics = {
            globals = { 'vim' },
          },

          workspace = {
            library = vim.api.nvim_get_runtime_file('', true),
            checkThirdParty = false
          },
        },
      },
    }
  end,
  ['jsonls'] = function(_)
    lsp.jsonls.setup({
      on_attach = on_attach,
      flags = lsp_flags,
      capabilities = capabilities,
      settings = {
        json = {
          schemas = {
            {
              fileMatch = { "package.json" },
              url = "https://json.schemastore.org/package.json",
            },
            {
              fileMatch = { "tsconfig*.json" },
              url = "https://json.schemastore.org/tsconfig.json",
            },
            {
              fileMatch = {
                ".prettierrc",
                ".prettierrc.json",
                "prettier.config.json",
              },
              url = "https://json.schemastore.org/prettierrc.json",
            },
            {
              fileMatch = { ".eslintrc", ".eslintrc.json" },
              url = "https://json.schemastore.org/eslintrc.json",
            },
            {
              fileMatch = {
                ".stylelintrc",
                ".stylelintrc.json",
                "stylelint.config.json",
              },
              url = "http://json.schemastore.org/stylelintrc.json",
            },
            {
              fileMatch = { "/.github/workflows/*" },
              url = "https://json.schemastore.org/github-workflow.json",
            },
          }
        }
      }
    })
  end,
  ['stylelint_lsp'] = function(_)
    lsp.stylelint_lsp.setup({
      on_attach = on_attach,
      flags = lsp_flags,
      capabilities = capabilities,
      filetypes = {
        "css",
        "less",
        "scss",
        "sugarss",
        "vue",
        "wxss",
      },
    })
  end
})

-- mason doesn't have `dartls` install option
lsp.dartls.setup {
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities,
  cmd = { 'dart', 'language-server', '--protocol=lsp' },
  filetypes = { 'dart' },
  root_pattern = { 'pubspec.yaml' },
  init_options = {
    closingLabels = true,
    flutterOutline = true,
    onlyAnalyzeProjectsWithOpenFiles = true,
    outline = true,
    suggestFromUnimportedLibraries = true
  },
  settings = {
    dart = {
      completeFunctionCalls = true,
      showTodos = true
    }
  },
}
