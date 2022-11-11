local ok, saga = pcall(require, 'lspsaga')
if (not ok) then return end

saga.init_lsp_saga {
  border_style = 'rounded',
  saga_winblend = 10,
  move_in_saga = { prev = '<C-p>', next = '<C-n>' },
  diagnostic_header = { ' ', ' ', ' ', 'ﴞ ' },
  max_preview_lines = 10,
  code_action_icon = '💡',
  code_action_num_shortcut = true,
  code_action_lightbulb = {
    enable = true,
    sign = true,
    enable_in_insert = true,
    sign_priority = 20,
    virtual_text = false,
  },
  finder_icons = {
    def = '  ',
    ref = '諭 ',
    link = '  ',
  },
  finder_request_timeout = 1500,
  finder_action_keys = {
    open = '<CR>',
    vsplit = 'v',
    split = 's',
    tabe = 't',
    quit = 'q',
    scroll_down = 'j',
    scroll_up = 'k',
  },
  code_action_keys = {
    quit = 'q',
    exec = '<CR>',
  },
  rename_action_quit = '<C-c>',
  rename_in_select = true,
  -- show symbols in winbar must nightly
  symbol_in_winbar = {
    in_custom = false,
    enable = false,
    separator = ' ',
    show_file = true,
    click_support = false,
  },
  show_outline = {
    win_position = 'right',
    win_with = '',
    win_width = 30,
    auto_enter = true,
    auto_preview = true,
    virt_text = '┃',
    jump_key = '<CR>',
    auto_refresh = true,
  },
}

local keymap = vim.keymap.set

local opts = { noremap = true, silent = true }
-- Diagnsotic jump can use `<c-o>` to jump back
keymap('n', '<C-j>', '<Cmd>Lspsaga diagnostic_jump_next<CR>', opts)
keymap('n', '<C-k>', '<Cmd>Lspsaga diagnostic_jump_prev<CR>', opts)

-- Only jump to error
keymap('n', '[E', function()
  require('lspsaga.diagnostic').goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, opts)
keymap('n', ']E', function()
  require('lspsaga.diagnostic').goto_next({ severity = vim.diagnostic.severity.ERROR })
end, opts)

-- Lsp finder find the symbol definition implement reference
-- if there is no implement it will hide
-- when you use action in finder like open vsplit then you can
-- use <C-t> to jump back
keymap('n', 'gf', '<cmd>Lspsaga lsp_finder<CR>', opts)

-- Peek Definition
-- you can edit the definition file in this flaotwindow
-- also support open/vsplit/etc operation check definition_action_keys
-- support tagstack C-t jump back
keymap('n', 'gp', '<Cmd>Lspsaga peek_definition<CR>', opts)

-- Outline
keymap("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", opts)

keymap('n', '<leader>r', '<Cmd>Lspsaga rename<CR>', opts)
keymap('n', '<leader>a', '<cmd>Lspsaga code_action<CR>', opts)
keymap('v', '<leader>a', '<cmd>Lspsaga range_code_action<CR>', opts)
keymap('n', '<leader>d', '<cmd>Lspsaga show_cursor_diagnostics<CR>', opts)
-- keymap("n", "<leader>ld", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
keymap('n', 'K', '<Cmd>Lspsaga hover_doc<CR>', opts)
-- vim.keymap.set('i', '<C-k>', '<Cmd>Lspsaga signature_help<CR>', opts)

vim.api.nvim_create_autocmd({ 'BufRead' }, {
  pattern = { '*' },
  callback = function()
    -- Colors from 'hybrid.vim'
    vim.api.nvim_set_hl(0, 'DiagnosticError', { fg = '#CC6666' })
    vim.api.nvim_set_hl(0, 'DiagnosticWarn', { fg = '#F0C674' })
    vim.api.nvim_set_hl(0, 'DiagnosticHint', { fg = '#81A2BE' })
    vim.api.nvim_set_hl(0, 'DiagnosticInfo', { fg = '#B5BD68' })
  end
})
