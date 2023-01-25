local function ensure_packer()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local bootstrap = ensure_packer()

local ok, packer = pcall(require, "packer")
if not ok then
	return
end

packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

return packer.startup(function(use)
	use({ "wbthomason/packer.nvim" })

	use({
		"w0ng/vim-hybrid",
		config = [[require("plugins.configs.hybrid")]],
	})

	use({
		"nvim-treesitter/nvim-treesitter",
		config = [[require("plugins.configs.treesitter")]],
	})

	use({
		"nvim-treesitter/nvim-treesitter-context",
		event = { "BufReadPre" },
		wants = { "nvim-treesitter" },
		config = [[require("plugins.configs.treesitter-context")]],
	})

	use({
		"RRethy/nvim-treesitter-endwise",
		event = { "InsertEnter" },
		wants = { "nvim-treesitter" },
	})

	use({
		"windwp/nvim-ts-autotag",
		event = { "InsertEnter" },
		wants = { "nvim-treesitter" },
		config = [[require("plugins.configs.autotag")]],
	})

	use({
		"windwp/nvim-autopairs",
		event = { "InsertEnter" },
		wants = { "nvim-treesitter" },
		config = [[require("plugins.configs.autopairs")]],
	})

	use({
		"L3MON4D3/LuaSnip",
		require = {
			{ "rafamadriz/friendly-snippets" },
		},
		config = [[require("plugins.configs.luasnip")]],
	})

	use({
		"williamboman/mason.nvim",
		requires = {
			"williamboman/mason-lspconfig.nvim",
		},
		config = [[require("plugins.configs.mason")]],
	})

	use({
		"jose-elias-alvarez/null-ls.nvim",
		event = { "BufEnter" },
		-- wants = { "mason" },
		config = [[require("plugins.configs.nullls")]],
	})

	use({
		"glepnir/lspsaga.nvim",
		config = [[require("plugins.configs.lspsaga")]],
	})

	use({
		"onsails/lspkind-nvim",
		config = [[require("plugins.configs.lspkind")]],
	})

	use({
		"neovim/nvim-lspconfig",
		module = { "lspconfig" },
		require = {
			{ "hrsh7th/cmp-nvim-lsp", event = { "InsertEnter" } },
		},
		wants = { "cmp-nvim-lsp" },
		config = [[require("plugins.configs.lspconfig")]],
	})

	use({
		"hrsh7th/nvim-cmp",
		requires = {
			{ "hrsh7th/cmp-buffer", event = { "InsertEnter" } },
			{ "hrsh7th/cmp-path", event = { "InsertEnter" } },
			{ "hrsh7th/cmp-nvim-lsp", event = { "InsertEnter" } },
			{ "hrsh7th/cmp-nvim-lsp-signature-help", event = { "InsertEnter" } },
			{ "hrsh7th/cmp-calc", event = { "InsertEnter" } },
			{ "hrsh7th/cmp-cmdline", event = { "CmdlineEnter" } },
			{ "saadparwaiz1/cmp_luasnip", event = { "InsertEnter" } },
		},
		wants = { "luasnip" },
		config = [[require("plugins.configs.cmp")]],
	})

	use({
		"kyazdani42/nvim-web-devicons",
		config = [[require("plugins.configs.devicons")]],
	})

	use({
		"nvim-telescope/telescope.nvim",
		module = { "telescope" },
		requires = {
			{ "nvim-lua/plenary.nvim", opt = true },
			{ "BurntSushi/ripgrep", opt = true },
			{ "sharkdp/fd", opt = true },
			{ "nvim-telescope/telescope-file-browser.nvim", opt = true },
		},
		wants = {
			"plenary.nvim",
			"ripgrep",
			"fd",
			"telescope-file-browser.nvim",
		},
		setup = [[require("plugins.setups.telescope")]],
		config = [[require("plugins.configs.telescope")]],
	})

	use({
		"nvim-lualine/lualine.nvim",
		config = [[require("plugins.configs.lualine")]],
	})

	use({
		"numToStr/Comment.nvim",
		config = [[require("plugins.configs.comment")]],
	})

	use({
		"kylechui/nvim-surround",
		tag = "*",
		config = [[require("nvim-surround").setup({})]],
	})

	use("lukas-reineke/indent-blankline.nvim")

	use({
		"lewis6991/gitsigns.nvim",
		config = [[require("plugins.configs.gitsigns")]],
	})

	-- use({
	-- 	"pwntester/octo.nvim",
	-- 	config = [[require("plugins.configs.octo")]],
	-- })

	use({
		"akinsho/bufferline.nvim",
		version = "v2.*",
		config = [[require("plugins.configs.bufferline")]],
	})

	use({
		"kevinhwang91/nvim-hlslens",
		config = [[require("plugins.configs.hlslens")]],
	})

	use({
		"akinsho/toggleterm.nvim",
		tag = "*",
		config = [[require("plugins.configs.toggleterm")]],
	})

	use({
		"norcalli/nvim-colorizer.lua",
		config = [[require("plugins.configs.colorizer")]],
	})

	use({
		"instant-markdown/vim-instant-markdown",
		ft = { "markdown" },
		config = [[require("plugins.configs.instantmarkdown")]],
	})

	if bootstrap then
		packer.sync()
	end
end)
