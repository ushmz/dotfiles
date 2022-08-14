local ok, coc = pcall(require, 'coc')
if (not ok) then return end

-- Some servers have issues with backup files, see #649.
vim.opt.backup = false
vim.opt.writebackup = false

-- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
-- delays and poor user experience.
vim.opt.updatetime  = 300

--Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appear/become resolved.
vim.opt.signcolumn = true

-- Use tab for trigger completion with characters ahead and navigate.
-- NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
-- other plugin before putting this into your config.
-- -- inoremap <silent><expr> <TAB>
-- --       \ coc#pum#visible() ? coc#pum#next(1):
-- --       \ CheckBackspace() ? "\<Tab>" :
-- --       \ coc#refresh()
-- -- inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

function check_backspace()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
        return true
    else
        return false
    end
end

function next_completion(callback)
    if coc.pum.visible() then
        coc.pum.next(1)
    elseif check_backspace() then
        callback()
    else
        coc.refresh()
    end
end

function _G.prev_completion()
end

vim.keymap.set('i', '<TAB>', function(callback)
    if coc.pum.visible() then
        coc.pum.next(1)
    elseif check_backspace() then
        callback()
    else
        coc.refresh()
    end
end, {silent = false})

vim.keymap.set('i', '<S-TAB>', function()
    if coc.pum.visible() then
        coc.pum.prev(1)
    else
        feedkey("<C-h>")
    end
end, {silent = true, expr = true})

-- Make <CR> to accept selected completion item or notify coc.nvim to format
-- <C-g>u breaks current undo, please make your own choice.
vim.keymap.set('i', '<CR>', function()
    if coc.pum.visible() then
        coc.pum.confirm()
    else
        feedkey("<C-g>u<CR><c-r>=coc#on_enter()<CR>")
    end
end, {silent = true, expr = true})
