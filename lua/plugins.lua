local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- base16_theme = 'material-darker'

return require("packer").startup(function(use)
	-- add packer itself to packer manager, to avoid remove
	use("wbthomason/packer.nvim")

	-- themes
	use({
		"RRethy/nvim-base16",
		requires = { "xiyaowong/nvim-transparent", "marko-cerovac/material.nvim" },
		config = function()
			require("plugins.settings.themes")
		end,
	})

	-- lsp and cmp
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			"neovim/nvim-lspconfig",
			"williamboman/nvim-lsp-installer",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-vsnip",
			"hrsh7th/vim-vsnip",
			"windwp/nvim-autopairs",
			"rafamadriz/friendly-snippets",
			"onsails/lspkind-nvim",
			"simrat39/rust-tools.nvim",
			"nvim-lua/lsp-status.nvim",
			"mfussenegger/nvim-jdtls",
			"tami5/lspsaga.nvim",
			"btstream/nvim-dotnvim",
		},
		config = function()
			require("plugins.settings.cmp")
			require("plugins.settings.lsp")
		end,
	})

	use({
		"simrat39/symbols-outline.nvim",
		config = function()
			require("plugins.settings.symbols_outline")
		end,
	})

	-- null-ls
	use({
		"jose-elias-alvarez/null-ls.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("plugins.settings.lsp.null_ls")
		end,
	})

	-- dap
	use({
		"mfussenegger/nvim-dap",
		requires = { "theHamsta/nvim-dap-virtual-text", "rcarriga/nvim-dap-ui" },
		config = function()
			require("plugins.settings.dap")
		end,
	})

	use({
		"Pocco81/DAPInstall.nvim",
		branch = "dev",
	})

	use({
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	})

	-- nvim treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		requires = { "p00f/nvim-ts-rainbow" },
		run = ":TSUpdate",
		config = function()
			require("plugins.settings.treesitter")
		end,
	})

	-- indent line
	use({
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("plugins.settings.indent_line")
		end,
	})

	-- status line and tabbar
	use({
		"NTBBloodbath/galaxyline.nvim",
		requires = { { "kyazdani42/nvim-web-devicons" }, { "RRethy/nvim-base16", opt = true } },
		after = "nvim-base16",
		config = function()
			require("plugins.settings.statusline").setup()
		end,
	})

	use({
		"akinsho/bufferline.nvim",
		requires = { "kyazdani42/nvim-web-devicons" },
		config = function()
			require("plugins.settings.tabbar")
		end,
	})

	-- which-key
	use({
		"folke/which-key.nvim",
		config = function()
			require("which-key").setup({ window = { border = "single" } })
		end,
	})

	-- terminal
	use({
		"akinsho/toggleterm.nvim",
		config = function()
			require("plugins.settings.terminal")
		end,
	})

	-- telescope
	use({
		"nvim-telescope/telescope.nvim",
		requires = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope-ui-select.nvim" },
		config = function()
			require("plugins.settings.telescope")
		end,
	})

	use({
		"nvim-telescope/telescope-file-browser.nvim",
		after = "telescope.nvim",
		config = function()
			require("plugins.settings.file_explorer")
			-- require('telescope').load_extension('file_browser')
		end,
	})

	-- dashboard
	use({
		"glepnir/dashboard-nvim",
		config = function()
			require("plugins.settings.dashboard")
		end,
	})

	-- nvim-tree
	use({
		"kyazdani42/nvim-tree.lua",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("plugins.settings.nvim_tree")
		end,
	})

	-- project
	use({
		"ahmedkhalf/project.nvim",
		after = "telescope.nvim",
		config = function()
			require("plugins.settings.project")
		end,
	})

	-- comments
	use({
		"numToStr/Comment.nvim",
		tag = "v0.6",
		config = function()
			require("plugins.settings.comments")
		end,
	})

	use({
		"danymat/neogen",
		config = function()
			require("neogen").setup({ enabled = true })
		end,
		requires = "nvim-treesitter/nvim-treesitter",
	})

	-- gitsigns
	use({
		"lewis6991/gitsigns.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("gitsigns").setup()
		end,
	})

	-- git-blame
	use({
		"f-person/git-blame.nvim",
		config = function()
			require("plugins.settings.gitblame")
		end,
	})

	use("h-hg/fcitx.nvim")

	-- markdown preview
	use({
		"iamcco/markdown-preview.nvim",
		run = function()
			vim.cmd("call mkdp#util#install()")
		end,
	})

	-- SnipR
	use({
		"michaelb/sniprun",
		run = "bash ./install.sh",
		cond = function()
			-- only load on macos and linux
			return vim.fn.has("win32") == 0
		end,
		config = function()
			require("plugins.settings.sniprun")
		end,
	})

	use({
		"lambdalisue/suda.vim",
		config = function()
			vim.g.suda_smart_edit = 1
		end,
	})

	-- rest tools
	use({
		"NTBBloodbath/rest.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("plugins.settings.rest_nvim")
		end,
	})

	use({ "editorconfig/editorconfig-vim" })
	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require("packer").sync()
	end
end)
