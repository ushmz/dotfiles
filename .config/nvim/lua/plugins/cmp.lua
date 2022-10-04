local ok, cmp = pcall(require, 'cmp')
if (not ok) then return end
local lspkind = require 'lspkind'
local luasnip = require 'luasnip'

local has_words_before = function()
  local cursor = vim.api.nvim_win_get_cursor(0)
  return (vim.api.nvim_buf_get_lines(0, cursor[1] - 1, cursor[1], true)[1] or ''):sub(cursor[2], cursor[2]):match('%s')
end

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    -- ['<C-k>'] = cmp.mapping.scroll_docs(-4),
    -- ['<C-j>'] = cmp.mapping.scroll_docs(4),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        -- if vim.fn.pumvisible() == 1 then
        cmp.select_next_item()
      elseif has_words_before() and luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        -- The fallback function sends a already mapped key.
        -- In this case, it's probably `<Tab>`.
        fallback()
      end
    end, { 'i', 's' }),

    ['<S-Tab>'] = cmp.mapping(function()
      if cmp.visible() then
        -- if vim.fn.pumvisible() == 1 then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) == 1 then
        luasnip.jump_prev()
      end
    end, { 'i', 's' }),
    ['<C-CR>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true
    }),
  }),
  sources = cmp.config.sources({
    { name = 'luasnip' },
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' }
  }),
  formatting = {
    format = lspkind.cmp_format({ with_text = false, maxwidth = 50 })
  }
})

vim.cmd [[
    set completeopt=menuone,noinsert,noselect
    highlight! default link CmpItemKind CmpItemMenuDefault
]]
