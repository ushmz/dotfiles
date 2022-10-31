local status1, cmp = pcall(require, 'cmp')
if (not status1) then return end

local status2, lspkind = pcall(require, 'lspkind')
if (not status2) then return end

local status3, luasnip = pcall(require, 'luasnip')
if (not status3) then return end

local has_words_before = function()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local lines = vim.api.nvim_buf_get_lines(0, cursor[1] - 1, cursor[1], true)
  return cursor[2] ~= 0 and (lines[1] or ''):sub(cursor[2], cursor[2]):match('%s') == nil
end

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.jumpable(1) then
        luasnip.jump(1)
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif luasnip.expandable() then
        luasnip.expand()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<C-CR>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true
    }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'hrsh7th/cmp-nvim-lsp-signature-help' },
    { name = 'buffer' },
    { name = 'path' },
    { name = 'calc' }
  }),
  formatting = {
    format = lspkind.cmp_format({ with_text = false, maxwidth = 50 })
  }
})

cmp.setup.cmdline(':', {
  sources = {
    { name = 'cmdline' }
  }
})

cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})

vim.api.nvim_set_var('completeopt', 'menuone,preview,noinsert,noselect')
vim.api.nvim_set_hl(0, 'CmpItemKind', { link = 'CmpItemMenuDefault' })
