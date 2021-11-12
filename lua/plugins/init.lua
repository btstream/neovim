local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({
        'git',
        'clone',
        '--depth',
        '1',
        'https://github.com/wbthomason/packer.nvim',
        install_path
    })
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost init.lua source <afile> | PackerSync
  augroup end
]])

-- base16_theme = 'material-darker'

return require('packer').startup(function(use)

    -- add packer itself to packer manager, to avoid remove
    use 'wbthomason/packer.nvim'

    -- themes
    use {
        'RRethy/nvim-base16',
        requires = { 'xiyaowong/nvim-transparent' },
        config = function()
            require('plugins.settings.themes')
        end
    }

    -- lsp and cmp
    use {
        'hrsh7th/nvim-cmp',
        requires = {
            'neovim/nvim-lspconfig',
            'williamboman/nvim-lsp-installer',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lua',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-vsnip',
            'hrsh7th/vim-vsnip',
            'windwp/nvim-autopairs',
            'rafamadriz/friendly-snippets',
            'onsails/lspkind-nvim',
            'simrat39/rust-tools.nvim',
            'nvim-lua/lsp-status.nvim',
            'mfussenegger/nvim-jdtls',
            -- 'glepnir/lspsaga.nvim'
            { 'tami5/lspsaga.nvim', branch = 'nvim51' }
        },
        config = function()
            require('plugins.settings.cmp')
            require('plugins.settings.lsp')
        end
    }

    use {
        'simrat39/symbols-outline.nvim',
        config = function()
            require('plugins.settings.symbols_outline')
        end
    }

    use {
        'norcalli/nvim-colorizer.lua',
        config = function()
            require('colorizer').setup()
        end
    }

    -- nvim treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function()
            require('plugins.settings.treesitter')
        end
    }

    -- indent line
    use {
        'lukas-reineke/indent-blankline.nvim',
        config = function()
            require('plugins.settings.indent_line')
        end
    }

    -- status line and tabbar
    use {
        "NTBBloodbath/galaxyline.nvim",
        requires = { { "kyazdani42/nvim-web-devicons" }, { 'RRethy/nvim-base16', opt = true } },
        after = 'nvim-base16',
        config = function()
            require('plugins.settings.statusline').setup()
        end
    }

    use {
        'akinsho/bufferline.nvim',
        requires = { 'kyazdani42/nvim-web-devicons' },
        config = function()
            require('plugins.settings.tabbar')
        end
    }

    -- which-key
    use {
        "folke/which-key.nvim",
        config = function()
            require('which-key').setup({})
        end
    }

    -- terminal
    use {
        "akinsho/toggleterm.nvim",
        config = function()
            require('plugins.settings.terminal')
        end
    }

    -- telescope
    use {
        'nvim-telescope/telescope.nvim',
        requires = 'nvim-lua/plenary.nvim',
        config = function()
            require('plugins.settings.telescope')
        end
    }

    -- dashboard
    use {
        'glepnir/dashboard-nvim',
        config = function()
            require('plugins.settings.dashboard')
        end
    }

    -- nvim-tree
    use {
        'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons',
        config = function()
            require('plugins.settings.nvim_tree')
        end
    }

    -- project
    use {
        "ahmedkhalf/project.nvim",
        config = function()
            require('plugins.settings.project')
        end
    }

    -- comments
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('plugins.settings.comments')
        end
    }

    -- gitsigns
    use {
        'lewis6991/gitsigns.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('gitsigns').setup()
            local signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }
            for type, icon in pairs(signs) do
                local hl = "LspDiagnosticsSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
            end
        end
    }

    use 'h-hg/fcitx.nvim'

    -- markdown preview
    use {
        'iamcco/markdown-preview.nvim',
        run = function()
            vim.cmd("call mkdp#util#install()")
        end
    }

    -- SnipR
    use {
        'michaelb/sniprun',
        run = 'bash ./install.sh',
        cond = function()
        -- only load on macos and linux
            return vim.fn.has('win32') == 0
        end,
        config = function ()
            require("plugins.settings.sniprun")
        end
    }

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then require('packer').sync() end
end)
