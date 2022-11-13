local status1, nls = pcall(require, 'null-ls')
if (not status1) then return end

local status2, mp = pcall(require, 'mason-core.package')
if (not status2) then return end

local status3, mr = pcall(require, 'mason-registry')
if (not status3) then return end

local nls_sources = {}

for _, package in ipairs(mr.get_installed_packages()) do
  local categories = package.spec.categories[1]
  if categories == mp.Cat.Formatter then
    table.insert(nls_sources, nls.builtins.formatting[package.name])
  end
  if categories == mp.Cat.Linter then
    table.insert(nls_sources, nls.builtins.diagnostics[package.name])
  end
end

-- Following tools cannot install via `ensure_installed` option of mason,
local ext_fmt = {
  'dart_format',
  'ktlint',
  'markdownlint',
  'rubocop',
  'black',
  'goimports',
  'prettier',
  'shfmt',
  'yamlfmt',
}

local ext_diag = {
  'flake8',
  'rubocop',
}

for _, fmt in ipairs(ext_fmt) do
  table.insert(nls_sources, nls.builtins.formatting[fmt])
end

for _, diag in ipairs(ext_diag) do
  table.insert(nls_sources, nls.builtins.diagnostics[diag])
end

local fmtag = vim.api.nvim_create_augroup('LspDocumentFormatting', {})
nls.setup({
  sources = nls_sources,
  on_attach = function(client, bufnr)
    if client.server_capabilities.documentFormattingProvider then
      vim.api.nvim_clear_autocmds({ buffer = bufnr, group = fmtag })
      vim.api.nvim_create_autocmd('BufWritePre', {
        buffer = bufnr,
        group = fmtag,
        callback = function()
          vim.lsp.buf.format({
            bufnr = bufnr,
            filter = function(clt)
              return clt.name == 'null-ls'
            end,
          })
        end,
      })
    end
  end
})
