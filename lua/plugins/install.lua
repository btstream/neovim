local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function()
    -- add packer itself to packer manager, to avoid remove
    use {'wbthomason/packer.nvim'}

    -- themes
    use 'RRethy/nvim-base16'

    -- lsp and cmp
    use 'neovim/nvim-lspconfig'
    use 'williamboman/nvim-lsp-installer'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/vim-vsnip'

    -- indent line
    use 'lukas-reineke/indent-blankline.nvim'

    -- galaxy line
    use {
        "NTBBloodbath/galaxyline.nvim",
        requires = { "kyazdani42/nvim-web-devicons", opt = true }
    }

    -- terminal
    use {"akinsho/toggleterm.nvim"}

    -- telescope
    use {
         'nvim-telescope/telescope.nvim',
         requires = { {'nvim-lua/plenary.nvim'} }
    }

    -- dashboard
    use 'glepnir/dashboard-nvim'

    -- nvim-tree
    use {
        'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons'
    }

    -- project
    use {
        "ahmedkhalf/project.nvim",
    }

    use 'liuchengxu/vista.vim'
    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end
end)
