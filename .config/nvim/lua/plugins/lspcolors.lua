local ok, colors = pcall(require, 'lsp-colors')
if (not ok) then return end

-- Colors based on w0ng/hybrid
colors.setup {
  Error = '#CC6666',
  Warning = '#F0C674',
  Information = '#B5BD68',
  Hint = '#81A2BE'
}
