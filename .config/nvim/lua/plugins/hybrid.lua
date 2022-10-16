vim.cmd('syntax on')

vim.api.nvim_set_var('background', 'dark')
vim.api.nvim_set_var('hybrid_use_term_colors', 1)
vim.api.nvim_set_var('hybrid_reduced_contrast', 0)

vim.api.nvim_create_autocmd({ 'VimEnter' }, {
  nested = true,
  command = 'colorscheme hybrid'
})
