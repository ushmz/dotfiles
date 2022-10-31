local ok, toggleterm = pcall(require, 'toggleterm')
if (not ok) then return end

toggleterm.setup({
  hidden = true,
  direction = 'float',
  float_opts = {
    border = 'curved',
  },
})

local Terminal = require('toggleterm.terminal').Terminal
local opt = { silent = true, noremap = true }

local term = Terminal:new({})
vim.keymap.set('n', [[<C-\>]], function()
  term:toggle()
end, opt)

local tig = Terminal:new({ cmd = 'tig' })
vim.keymap.set('n', ';t', function()
  tig:toggle()
end, opt)
