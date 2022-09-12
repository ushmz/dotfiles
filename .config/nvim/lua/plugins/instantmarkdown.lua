local api = vim.api

api.nvim_set_var('instant_markdown_slow', 1)
api.nvim_set_var('instant_markdown_autostart', 0)
api.nvim_set_var('instant_markdown_open_to_the_world', 1)
api.nvim_set_var('instant_markdown_allow_unsafe_content', 1)
api.nvim_set_var('instant_markdown_allow_external_content', 0)
api.nvim_set_var('instant_markdown_mathjax', 1)
api.nvim_set_var('instant_markdown_mermaid', 1)
local state_dir = vim.env.XDG_STATE_HOME
api.nvim_set_var('instant_markdown_logfile', state_dir .. '/nvim/instant_markdown.log')
api.nvim_set_var('instant_markdown_autoscroll', 0)
api.nvim_set_var('instant_markdown_port', 8090)
api.nvim_set_var('instant_markdown_python', 1)

local key = vim.keymap
key.set('n', '<leader>mp', ':<C-u>InstantMarkdownPreview<CR>')
key.set('n', '<leader>ms', ':<C-u>InstantMarkdownStop<CR>')
