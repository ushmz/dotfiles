vim.cmd("autocmd!")

-- filetype
vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
    pattern = {'*.jsx'},
    command = 'set filetype=javascriptreact'
})

vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
    pattern = {'*.tsx'},
    command = 'set filetype=typescriptreact'
})

vim.api.nvim_create_autocmd({'FileType'}, {
    pattern = {'javascriptreact', 'typescriptreact', 'dart', 'lua', 'vim'},
    command = 'set tabstop=2 shiftwidth=2 softtabstop=2'
})

-- templates
vim.api.nvim_create_autocmd({'BufNewFile'}, {
    pattern = {'*.sh'},
    command = '0r $HOME/.vim/templates/skeleton.sh'
})


local config_dir = vim.env.XDG_CONFIG_HOME
vim.api.nvim_set_var('python3_host_prog', config_dir .. '/nvim/pynvim/bin/python')

require('options')
require('mappings')
require('plugins')