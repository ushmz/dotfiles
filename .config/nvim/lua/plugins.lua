vim.cmd [[packadd packer.nvim]]

local ok, packer = pcall(require, 'packer')
if (not ok) then return end

return packer.startup(function(use)
  use 'wbthomason/packer.nvim'

  use {
    'w0ng/vim-hybrid',
    config = function() require('plugins.hybrid') end
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    config = function() require('plugins.treesitter') end
  }

  use 'nvim-treesitter/playground'

  use {
    'onsails/lspkind-nvim',
    config = function() require('plugins.lspkind') end
  }

  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp',
      'L3MON4D3/LuaSnip',
    },
    config = function() require('plugins.cmp') end
  }

  use {
    'glepnir/lspsaga.nvim',
    config = function() require('plugins.lspsaga') end
  }

  use {
    'neovim/nvim-lspconfig',
    requires = {
      'glepnir/lspsaga.nvim',
    },
    config = function() require('plugins.lspconfig') end
  }

  use {
    'williamboman/mason.nvim',
    requires = {
      'williamboman/mason-lspconfig.nvim',
    },
    config = function() require('plugins.mason') end
  }

  use {
    'kyazdani42/nvim-web-devicons',
    config = function() require('plugins.devicons') end
  }

  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'BurntSushi/ripgrep',
      'sharkdp/fd',
      'nvim-telescope/telescope-file-browser.nvim',
    },
    config = function() require('plugins.telescope') end
  }

  use {
    'nvim-lualine/lualine.nvim',
    config = function() require('plugins.lualine') end
  }

  use {
    'windwp/nvim-ts-autotag',
    config = function() require('plugins.autotag') end
  }

  use {
    'windwp/nvim-autopairs',
    config = function() require('plugins.autopairs') end
  }

  use {
    'numToStr/Comment.nvim',
    config = function() require('plugins.comment') end
  }

  use({
    'kylechui/nvim-surround',
    tag = '*',
    config = function() require('nvim-surround').setup({}) end
  })

  use 'lukas-reineke/indent-blankline.nvim'

  use {
    'simeji/winresizer',
    config = function() require('plugins.winresizer') end
  }

  use {
    'lewis6991/gitsigns.nvim',
    config = function() require('plugins.gitsigns') end
  }

  use {
    'akinsho/bufferline.nvim',
    version = 'v2.*',
    config = function() require('plugins.bufferline') end
  }

  use {
    'rust-lang/rust.vim',
    ft = { 'rust' },
    config = function() vim.g.rustfmt_autosave = 1 end
  }

  use {
    'fatih/vim-go',
    ft = { 'go' },
    config = function() require('plugins.go') end
  }

  use {
    'instant-markdown/vim-instant-markdown',
    ft = { 'markdown' },
    config = function() require('plugins.instantmarkdown') end
  }

  use { 'thosakwe/vim-flutter', ft = { 'dart' } }
  use { 'dart-lang/dart-vim-plugin', ft = { 'dart' } }
  use { 'udalov/kotlin-vim', ft = { 'kotlin' } }
end)
