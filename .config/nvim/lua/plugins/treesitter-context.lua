local ok, context = pcall(require, 'treesitter-context')
if (not ok) then return end

context.setup {
  enable = true,
  max_lines = 0,
  trim_scope = 'outer',
  min_window_height = 0,
  patterns = {
    default = {
      'class',
      'function',
      'method',
      'for',
      'while',
      'if',
      'switch',
      'case',
      'interface',
      'struct',
      'enum',
    },
    markdown = {
      'section',
    },
    json = {
      'pair',
    },
    typescript = {
      'export_statement',
    },
    yaml = {
      'block_mapping_pair',
    },
  },
  exact_patterns = {},
}
