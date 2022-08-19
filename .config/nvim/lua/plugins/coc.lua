-- Some servers have issues with backup files, see #649.
vim.opt.backup = false
vim.opt.writebackup = false

-- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
-- delays and poor user experience.
vim.opt.updatetime = 300

-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appear/become resolved.
vim.opt.signcolumn = 'yes'

-- Use tab for trigger completion with characters ahead and navigate.
-- NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
-- other plugin before putting this into your config.
local function check_backspace()
  local col = vim.fn.col('.') - 1
  if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
    return true
  else
    return false
  end
end

vim.keymap.set('i', '<TAB>', function(callback)
  if vim.fn['coc#pum#visible']() then
    vim.fn['coc#pum#next'](1)
  elseif check_backspace() then
    callback()
  else
    vim.fn['coc#refresh']()
  end
end, { silent = true, expr = true })

vim.keymap.set('i', '<S-TAB>', function()
  if vim.fn['coc#pum#visible']() then
    vim.fn['coc#pum#prev'](1)
  else
    vim.fn.feedkeys('<C-h>')
  end
end, { silent = true, expr = true })

-- Make <CR> to accept selected completion item or notify coc.nvim to format
-- <C-g>u breaks current undo, please make your own choice.
vim.keymap.set('i', '<CR>', function()
  if vim.fn['coc#pum#visible']() then
    vim.fn['coc#pum#confirm']()
  else
    vim.fn.feedkeys('<c-r>=coc#on_enter()')
  end
end, { silent = true, expr = true })


-- Use `[g` and `]g` to navigate diagnostics
-- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
vim.keymap.set('n', '[g', '<Plug>(coc-diagnostic-prev)', { silent = true })
vim.keymap.set('n', ']g', '<Plug>(coc-diagnostic-next)', { silent = true })

-- GoTo code navigation.
vim.keymap.set('n', 'gd', '<Plug>(coc-definition)', { silent = true })
vim.keymap.set('n', 'gt', '<Plug>(coc-type-definition)', { silent = true })
vim.keymap.set('n', 'gi', '<Plug>(coc-implementation)', { silent = true })
vim.keymap.set('n', 'gr', '<Plug>(coc-references)', { silent = true })

-- Use K to show documentation in preview window.
local function show_documentation()
  if vim.fn['CocActionAsync']('hasProvider', 'hover') then
    vim.fn['CocActionAsync']('doHover')
  else
    vim.fn.feedkeys('K', 'in')
  end
end

vim.keymap.set('n', 'K', show_documentation(), { noremap = true, silent = true })

-- Highlight the symbol and its references when holding the cursor.
vim.api.nvim_create_autocmd({ 'CursorHold' }, {
  pattern = { '*' },
  command = 'silent call CocActionAsync('highlight')'
})

vim.highlight.create('CocInfoFloat', { ctermfg = 250, ctermbg = 237, guifg = '#C5C8C6', guibg = '#425059' }, false)
vim.highlight.create('CocSelectedText', { ctermfg = 237, ctermbg = 250, guifg = '#425059', guibg = '#C5C8C6' }, false)
vim.highlight.create('CocSelectedLine', { ctermfg = 237, ctermbg = 250, guifg = '#425059', guibg = '#C5C8C6' }, false)
vim.highlight.create('PmenuSel', { ctermfg = 237, ctermbg = 250, guifg = '#425059', guibg = '#C5C8C6' }, false)

-- Symbol renaming.
vim.keymap.set('n', '<leader>rn', '<Plug>(coc-rename)')

-- Formatting selected code.
vim.keymap.set('x', '<leader>f', '<Plug>(coc-format-selected)')
vim.keymap.set('n', '<leader>f', '<Plug>(coc-format-selected)')

vim.cmd [[
  augroup mygroup
    autocmd!
    ' Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    ' Update signature help on jump placeholder.
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  augroup end
]]

-- Applying codeAction to the selected region.
-- Example: `<leader>aap` for current paragraph
vim.keymap.set('x', '<leader>ac', '<Plug>(coc-codeaction-selected)')
vim.keymap.set('n', '<leader>ac', '<Plug>(coc-codeaction-selected)')

-- Remap keys for applying codeAction to the current buffer.
-- nmap <leader>ca  <Plug>(coc-codeaction)
-- Apply AutoFix to problem on the current line.
vim.keymap.set('n', '<leader>af', '<Plug>(coc-fix-current)')

-- Run the Code Lens action on the current line.
-- vim.cmd [[
--   nmap <leader>cl  <Plug>(coc-codelens-action)
-- ]]


-- Map function and class text objects
-- NOTE: Requires 'textDocument.documentSymbol' support from the language server.
vim.keymap.set('x', 'if', '<Plug>(coc-funcobj-i)')
vim.keymap.set('o', 'if', '<Plug>(coc-funcobj-i)')
vim.keymap.set('x', 'af', '<Plug>(coc-funcobj-a)')
vim.keymap.set('o', 'af', '<Plug>(coc-funcobj-a)')
vim.keymap.set('x', 'ic', '<Plug>(coc-classobj-i)')
vim.keymap.set('o', 'ic', '<Plug>(coc-classobj-i)')
vim.keymap.set('x', 'ac', '<Plug>(coc-classobj-a)')
vim.keymap.set('o', 'ac', '<Plug>(coc-classobj-a)')

-- Remap <C-j> and <C-k> for scroll float windows/popups.
vim.cmd [[
  if has('nvim-0.4.0') || has('patch-8.2.0750')
    nnoremap <silent><nowait><expr> <C-j> coc#float#has_scroll() ? coc#float#scroll(1) : '\<C-j>'
    nnoremap <silent><nowait><expr> <C-k> coc#float#has_scroll() ? coc#float#scroll(0) : '\<C-k>'
    inoremap <silent><nowait><expr> <C-j> coc#float#has_scroll() ? '\<c-r>=coc#float#scroll(1)\<cr>-- : '\<Right>'
    inoremap <silent><nowait><expr> <C-k> coc#float#has_scroll() ? '\<c-r>=coc#float#scroll(0)\<cr>-- : '\<Left>'
    vnoremap <silent><nowait><expr> <C-j> coc#float#has_scroll() ? coc#float#scroll(1) : '\<C-j>'
    vnoremap <silent><nowait><expr> <C-k> coc#float#has_scroll() ? coc#float#scroll(0) : '\<C-k>'
  endif
]]

-- Use CTRL-S for selections ranges.
-- Requires 'textDocument/selectionRange' support of language server.
vim.keymap.set('x', '<C-s>', '<Plug>(coc-range-select)', { silent = true })
vim.keymap.set('n', '<C-s>', '<Plug>(coc-range-select)', { silent = true })

-- Add `:Format` command to format current buffer.
vim.cmd [[
  command! -nargs=0 Format :call CocActionAsync('format')
]]

-- Add `:Fold` command to fold current buffer.
vim.cmd [[
  command! -nargs=? Fold :call     CocAction('fold', <f-args>)
]]

-- Add `:OR` command for organize imports of the current buffer.
vim.cmd [[
  command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')
]]

-- Add (Neo)Vim's native statusline support.
-- NOTE: Please see `:h coc-status` for integrations with external plugins that
-- provide custom statusline: lightline.vim, vim-airline.
vim.cmd [[
  set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
]]

-- Mappings for CoCList
-- Show all diagnostics.
vim.cmd [[
  nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
]]
-- Manage extensions.
vim.cmd [[
  nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
]]

-- Show commands.
-- vim.cmd [[
--   nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
-- ]]
-- Find symbol of current document.
vim.cmd [[
  nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
]]
-- Search workspace symbols.
-- vim.cmd [[
--   nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
-- ]]
-- Do default action for next item.
-- vim.cmd [[
--   nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
-- ]]
-- Do default action for previous item.
-- vim.cmd [[
--   nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
-- ]]
-- Resume latest coc list.
vim.cmd [[
  nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
]]
