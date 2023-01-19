vim.cmd [[packadd packer.nvim]]

local ok, packer = pcall(require, 'packer')
if (not ok) then return end

return packer.startup(function(use)
  use { 'wbthomason/packer.nvim', opt = true }

  use {
    'w0ng/vim-hybrid',
    config = function() require('plugins.hybrid') end
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    config = function() require('plugins.treesitter') end
  }

  use {
    'nvim-treesitter/nvim-treesitter-context',
    config = function() require('plugins.treesitter-context') end
  }


  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-calc',
      'hrsh7th/cmp-cmdline',
      'L3MON4D3/LuaSnip',
    },
    config = function() require('plugins.cmp') end
  }

  use {
    'jose-elias-alvarez/null-ls.nvim',
    requires = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
    },
    config = function()
      require('plugins.mason')
      require('plugins.nullls')
    end
  }

  use {
    'glepnir/lspsaga.nvim',
    config = function() require('plugins.lspsaga') end
  }

  use {
    'onsails/lspkind-nvim',
    config = function() require('plugins.lspkind') end
  }

  use {
    'neovim/nvim-lspconfig',
    config = function() require('plugins.lspconfig') end
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
    'lewis6991/gitsigns.nvim',
    config = function() require('plugins.gitsigns') end
  }

  use {
    'pwntester/octo.nvim',
    config = function() require('plugins.octo') end
  }

  use {
    'akinsho/bufferline.nvim',
    version = 'v2.*',
    config = function() require('plugins.bufferline') end
  }

  use {
    'kevinhwang91/nvim-hlslens',
    config = function() require('plugins.hlslens') end
  }

  use {
    'akinsho/toggleterm.nvim',
    tag = '*',
    config = function() require('plugins.toggleterm') end
  }

  use {
    'norcalli/nvim-colorizer.lua',
    config = function() require('plugins.colorizer') end
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
  use { 'tpope/vim-rails', ft = { 'ruby', 'eruby' } }
end)
