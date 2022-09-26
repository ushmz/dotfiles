local api = vim.api

local python_path = api.nvim_get_var('python3_host_prog')
api.nvim_set_var('ale_python_flake8_executable', python_path)
api.nvim_set_var('ale_python_flake8_options', '-m flake8')

api.nvim_set_var('ale_python_autopep8_executable', python_path)
api.nvim_set_var('ale_python_autopep8_options', '-m autopep8')

api.nvim_set_var('ale_python_isort_executable', python_path)
api.nvim_set_var('ale_python_isort_options', '-m isort')

api.nvim_set_var('ale_python_black_executable', python_path)
api.nvim_set_var('ale_python_black_options', '-m black')

api.nvim_set_var('ale_cursor_detail', 1)
api.nvim_set_var('ale_disable_lsp', 1)
api.nvim_set_var('ale_echo_cursor', 1)
api.nvim_set_var('ale_fix_on_save', 1)
api.nvim_set_var('ale_floating_preview', 1)
api.nvim_set_var('ale_hover_cursor', 1)
api.nvim_set_var('ale_lint_on_enter', 1)
api.nvim_set_var('ale_lint_on_text_changed', 1)
api.nvim_set_var('ale_set_signs', 1)
api.nvim_set_var('ale_set_highlights', 1)
api.nvim_set_var('ale_sign_column_always', 1)
api.nvim_set_var('ale_sign_warning', '⚠')
api.nvim_set_var('ale_linters_explicit', 1)

api.nvim_set_var('ale_fixers', {
  ['*'] = { 'remove_trailing_lines', 'trim_whitespace' },
  ['dart'] = { 'dart-format' },
  -- ['go'] = { 'gofmt', 'goimports', 'golines' },
  ['kotlin'] = { 'ktlint' },
  ['html'] = { 'HTMLHint' },
  ['css'] = { 'stylelint' },
  ['vue'] = { 'eslint', 'prettier' },
  ['sh'] = { 'shfmt' },
  ['javascript'] = { 'eslint', 'prettier' },
  ['javascriptreact'] = { 'eslint', 'prettier' },
  ['typescript'] = { 'eslint', 'prettier' },
  ['typescriptreact'] = { 'eslint', 'prettier' },
})

api.nvim_create_autocmd({ 'VimEnter', 'SourcePost' }, {
  pattern = { '*' },
  command = 'highlight ALEErrorSign ctermbg=none ctermfg=red'
})

api.nvim_create_autocmd({ 'VimEnter', 'SourcePost' }, {
  pattern = { '*' },
  command = 'highlight ALEWarningSign ctermbg=none ctermfg=yellow'
})

api.nvim_create_autocmd({ 'VimEnter', 'SourcePost' }, {
  pattern = { '*' },
  command = 'highlight ALEInfoSign ctermbg=none ctermfg=green'
})

api.nvim_create_autocmd({ 'VimEnter', 'SourcePost' }, {
  pattern = { '*' },
  command = 'highlight ALEError cterm=underline ctermfg=none ctermbg=none'
})

api.nvim_create_autocmd({ 'VimEnter', 'SourcePost' }, {
  pattern = { '*' },
  command = 'highlight ALEWarning cterm=underline ctermfg=none ctermbg=none'
})

api.nvim_create_autocmd({ 'VimEnter', 'SourcePost' }, {
  pattern = { '*' },
  command = 'highlight ALEInfo cterm=underline ctermfg=none ctermbg=none'
})

vim.keymap.set('n', '<leader>k', '<cmd>ALEPreviousWrap<CR>zz')
vim.keymap.set('n', '<leader>j', '<cmd>ALENextWrap<CR>zz')
vim.keymap.set('n', '<leader>x', '<cmd>ALEFix<CR>')

-- Show ale errors and warnings stats in statusline
--[[
function linter_status()
    local counts = vim.fn("ale#statusline#Count(bufnr(''))")
    local all_errors = counts.error + counts.style_error
    local all_non_errors = counts.total - all_errors

    local errSign = api.nvim_get_var('ALEErrorSign')
    local warnSign = api.nvim_get_var('ALEWarningSign')

    if counts.total == 0 then
        return 'OK'
    else
        printf('%d', errSign, '%d', 'warnSign', all_non_errors, all_errors)
    end
end

vim.cmd [[
    set statusline+=%=
    set statusline+=LinterStatus()
]]
--]]
