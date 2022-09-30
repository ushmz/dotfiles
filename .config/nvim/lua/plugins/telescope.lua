local ok, telescope = pcall(require, 'telescope')
if (not ok) then return end

local actions = require('telescope.actions')
local builtin = require('telescope.builtin')
local previewers = require('telescope.previewers')

local fb_actions = telescope.extensions.file_browser.actions

local function telescope_buffer_dir()
  return vim.fn.expand('%:p:h')
end

-- Ignore files bigger than a threshold
local function new_maker(filepath, bufnr, opts)
  opts = opts or {}
  filepath = vim.fn.expand(filepath)
  vim.loop.fs_stat(filepath, function(_, stat)
    if not stat then return end
    if stat.size > 100000 then
      return
    else
      previewers.buffer_previewer_maker(filepath, bufnr, opts)
    end
  end)
end

telescope.setup {
  defaults = {
    buffer_previewer_maker = new_maker,
    mappings = {
      n = {
        ['q'] = actions.close,
      },
    },
    file_ignore_patterns = {
      '*.DS_Store',
      '*.pyc',
      '.cache',
      '.cargo',
      '.git',
      '.npm',
      '.ssh',
      'node_modules',
      'site_packages',
      '__pycache__'
    }
  },
  pickers = {
    find_files = {
      find_command = { "fd", "--type", "f", "--strip-cwd-prefix" }
    },
  },
  extensions = {
    file_browser = {
      theme = 'dropdown',
      -- disables netrw and use telescope-file-browser in its place
      hijack_netrw = true,
      mappings = {
        ['i'] = {
          ['<C-w>'] = function() vim.cmd('normal vbd') end,
        },
        ['n'] = {
          ['l'] = function()
            return vim.api.nvim_replace_termcodes('<CR>', true, true, true)
          end,
          ['D'] = fb_actions.remove,
          ['H'] = fb_actions.toggle_hidden,
          ['N'] = fb_actions.create,
          ['h'] = fb_actions.goto_parent_dir,
          ['/'] = function()
            vim.cmd('startinsert')
          end
        },
      },
    },
  },
}
telescope.load_extension('file_browser')

-- keymaps
vim.keymap.set('n', ';f', function()
  builtin.find_files({
    no_ignore = false,
    grouped = true,
    hidden = true,
  })
end)

vim.keymap.set('n', ';g', function()
  builtin.live_grep({
    no_ignore = false,
    hidden = true,
    grouped = true,
  })
end)

vim.keymap.set('n', ';b', function()
  builtin.buffers()
end)

vim.keymap.set('n', ';h', function()
  builtin.help_tags()
end)

vim.keymap.set('n', ';;', function()
  builtin.resume()
end)

vim.keymap.set('n', ';e', function()
  builtin.diagnostics()
end)

vim.keymap.set('n', ';d', function()
  telescope.extensions.file_browser.file_browser({
    path = '%:p:h',
    cwd = telescope_buffer_dir(),
    respect_gitignore = false,
    hidden = true,
    grouped = true,
    previewer = false,
    initial_mode = 'normal',
    layout_config = { height = 40 }
  })
end)
