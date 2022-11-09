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

  local set = vim.keymap.set
  local opts = { noremap = true, silent = true }
  set('n', 'gd', vim.lsp.buf.definition, opts)
  set('n', 'gr', vim.lsp.buf.references, opts)
  set('n', 'gt', vim.lsp.buf.type_definition, opts)
  set('n', 'gi', vim.lsp.buf.implementation, opts)

  -- filter = function(cl) return cl.name == 'null-ls' end,
  local function buf_format()
    vim.lsp.buf.format({ bufnr = bufnr, timeout_ms = 3000 })
  end

  set('n', '<leader>f', buf_format, opts)
  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_create_augroup('lsp_document_formatting', { clear = true })
    vim.api.nvim_clear_autocmds({ buffer = bufnr, group = "lsp_document_formatting" })
    vim.api.nvim_create_autocmd('BufWritePre', {
      buffer = bufnr,
      group = 'lsp_document_formatting',
      callback = buf_format,
    })
  end

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
  ['sumneko_lua'] = function()
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
