local fn = vim.fn

-- require("utils")

-- load plugins
-- require("plugins/install")

-- load plugins settings
-- auto load configs
-- for i,j in pairs(fn.globpath(fn.stdpath('config')..'/lua/plugins/settings', '*.lua'):split('\n')) do
--     local s = j:split("/")
--     s = s[#s]:split(".")[1]
--     require("plugins/settings/"..s)
-- end

local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function(use)
    -- add packer itself to packer manager, to avoid remove
    use 'wbthomason/packer.nvim'

    -- themes
    use {
        'RRethy/nvim-base16',
        config = require('plugins.settings.base16')
    }

    -- lsp and cmp
    use {
        'hrsh7th/nvim-cmp',
        requires =  {
            'neovim/nvim-lspconfig',
            'williamboman/nvim-lsp-installer',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-vsnip',
            'hrsh7th/vim-vsnip'
        },
        config = require('plugins.settings.cmp')
    }

    -- nvim treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }

    -- indent line
    use {
        'lukas-reineke/indent-blankline.nvim',
        config = require('plugins.settings.indent_line')
    }

    -- status line and tabbar
    use {
        "NTBBloodbath/galaxyline.nvim",
        requires = { "kyazdani42/nvim-web-devicons", opt = true },
        config = require('plugins.settings.statusline')
    }

    use {
        'romgrk/barbar.nvim',
        requires = {'kyazdani42/nvim-web-devicons'},
        config = require('plugins.settings.barbar')
    }

    -- which-key
    use {
        "folke/which-key.nvim",
        config = require('which-key').setup({})
    }

    -- terminal
    use {
        "akinsho/toggleterm.nvim",
        config = require('plugins.settings.terminal')
    }

    -- telescope
    use {
        'nvim-telescope/telescope.nvim',
        requires = 'nvim-lua/plenary.nvim',
        config = require('plugins.settings.telescope')
    }

    -- dashboard
    use {
        'glepnir/dashboard-nvim',
        config = require('plugins.settings.dashboard')
    }

    -- nvim-tree
    use {
        'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons',
        config = require('plugins.settings.nvim_tree')
    }

    -- project
    use {
        "ahmedkhalf/project.nvim",
        config = require('plugins.settings.project')
    }

    -- comments
    use {
        'numToStr/Comment.nvim',
        config = require('plugins.settings.comments')
    }

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end
end)
