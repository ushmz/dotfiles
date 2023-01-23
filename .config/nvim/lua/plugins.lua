vim.cmd([[packadd packer.nvim]])

local ok, packer = pcall(require, "packer")
if not ok then
	return
end

return packer.startup(function(use)
	use({ "wbthomason/packer.nvim", opt = true })

	use({
		"w0ng/vim-hybrid",
		config = function()
			require("plugins.hybrid")
		end,
	})

	use({
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("plugins.treesitter")
		end,
	})

	use({
		"nvim-treesitter/nvim-treesitter-context",
		config = function()
			require("plugins.treesitter-context")
		end,
	})

	use({
		{ "L3MON4D3/LuaSnip" },
		"rafamadriz/friendly-snippets",
	})

	use({
		"hrsh7th/nvim-cmp",
		requires = {
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-path" },
			{ "hrsh7th/cmp-nvim-lsp-signature-help" },
			{ "hrsh7th/cmp-calc" },
			{ "hrsh7th/cmp-cmdline" },
		},
		wants = "LuaSnip",
		config = function()
			require("plugins.cmp")
		end,
	})

	use({
		"williamboman/mason.nvim",
		requires = {
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			require("plugins.mason")
		end,
	})

	use({
		"jose-elias-alvarez/null-ls.nvim",
		wants = "mason",
		config = function()
			require("plugins.nullls")
		end,
	})

	use({
		"glepnir/lspsaga.nvim",
		config = function()
			require("plugins.lspsaga")
		end,
	})

	use({
		"onsails/lspkind-nvim",
		config = function()
			require("plugins.lspkind")
		end,
	})

	use({
		"neovim/nvim-lspconfig",
		-- wants = { "cmp-nvim-lsp", "mason" },
		config = function()
			require("plugins.lspconfig")
		end,
	})

	use({
		"kyazdani42/nvim-web-devicons",
		config = function()
			require("plugins.devicons")
		end,
	})

	use({
		"nvim-telescope/telescope.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
			"BurntSushi/ripgrep",
			"sharkdp/fd",
			"nvim-telescope/telescope-file-browser.nvim",
		},
		wants = {
			"nvim-lua/plenary.nvim",
			"BurntSushi/ripgrep",
			"sharkdp/fd",
			"nvim-telescope/telescope-file-browser.nvim",
		},
		config = function()
			require("plugins.telescope")
		end,
	})

	use({
		"nvim-lualine/lualine.nvim",
		config = function()
			require("plugins.lualine")
		end,
	})

	use({
		"windwp/nvim-ts-autotag",
		config = function()
			require("plugins.autotag")
		end,
	})

	use({
		"windwp/nvim-autopairs",
		config = function()
			require("plugins.autopairs")
		end,
	})

	use({
		"numToStr/Comment.nvim",
		config = function()
			require("plugins.comment")
		end,
	})

	use({
		"kylechui/nvim-surround",
		tag = "*",
		config = function()
			require("nvim-surround").setup({})
		end,
	})

	use("lukas-reineke/indent-blankline.nvim")

	use({
		"lewis6991/gitsigns.nvim",
		config = function()
			require("plugins.gitsigns")
		end,
	})

	use({
		"pwntester/octo.nvim",
		config = function()
			require("plugins.octo")
		end,
	})

	use({
		"akinsho/bufferline.nvim",
		version = "v2.*",
		config = function()
			require("plugins.bufferline")
		end,
	})

	use({
		"kevinhwang91/nvim-hlslens",
		config = function()
			require("plugins.hlslens")
		end,
	})

	use({
		"akinsho/toggleterm.nvim",
		tag = "*",
		config = function()
			require("plugins.toggleterm")
		end,
	})

	use({
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("plugins.colorizer")
		end,
	})

	use({
		"instant-markdown/vim-instant-markdown",
		ft = { "markdown" },
		config = function()
			require("plugins.instantmarkdown")
		end,
	})
end)
