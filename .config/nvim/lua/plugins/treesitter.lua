local ok, ts = pcall(require, 'nvim-treesitter.configs')
if (not ok) then return end

ts.setup {
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },
  ensure_installed = {
    'bash',
    'css',
    'dart',
    'dockerfile',
    'go',
    'gomod',
    'html',
    'java',
    'javascript',
    'json',
    'jsonc',
    'kotlin',
    'lua',
    'make',
    'markdown',
    'prisma',
    'python',
    'regex',
    'rust',
    'scss',
    'toml',
    'tsx',
    'typescript',
    'vim',
    'vue',
    'yaml',
  },
  autotag = {
    enable = true
  }
}

local parser_config = require 'nvim-treesitter.parsers'.get_parser_configs()
parser_config.tsx.filetype_to_parsername = { 'javascript', 'typescript.tsx' }
