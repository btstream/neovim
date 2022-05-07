local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAPG = fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://hub.fastgit.xyz/wbthomason/packer.nvim",
        install_path,
    })
    print("Installing packer close and reopen Neovim...")
    vim.cmd([[packadd packer.nvim]])
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

vim.g.statusline = "lualine"

-- Have packer use a popup window
packer.init({
    display = {
        open_fn = function()
            return require("packer.util").float({ border = "rounded" })
        end,
    },
    git = {
        default_url_format = "https://hub.fastgit.xyz/%s",
    },
})

return require("packer").startup(function(use)
    -- add packer itself to packer manager, to avoid remove
    use("wbthomason/packer.nvim")

    -- themes
    use("xiyaowong/nvim-transparent")
    use("marko-cerovac/material.nvim")
    use("EdenEast/nightfox.nvim")
    use("rmehri01/onenord.nvim")
    use({
        "RRethy/nvim-base16",
        -- requires = { "xiyaowong/nvim-transparent", "marko-cerovac/material.nvim", "EdenEast/nightfox.nvim" },
        config = function()
            require("plugins.settings.themes")
        end,
    })

    use({
        "CosmicNvim/cosmic-ui",
        requires = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
        config = function()
            require("cosmic-ui").setup({
                -- default border to use
                -- 'single', 'double', 'rounded', 'solid', 'shadow'
                border_style = "single",

                -- rename popup settings
                rename = {
                    border = {
                        highlight = "FloatBorder",
                        style = "single",
                        title = " Rename ",
                        title_align = "left",
                        title_hl = "Normal",
                    },
                    prompt = "> ",
                    prompt_hl = "Normal",
                },

                code_actions = {
                    min_width = nil,
                    border = {
                        bottom_hl = "FloatBorder",
                        highlight = "FloatBorder",
                        style = "single",
                        title = "Code Actions",
                        title_align = "center",
                        title_hl = "Normal",
                    },
                },
            })
        end,
    })

    use({
        "rcarriga/nvim-notify",
        config = function()
            vim.notify = require("notify")
        end,
    })

    -- lsp
    use({
        "neovim/nvim-lspconfig",
        requires = {
            "williamboman/nvim-lsp-installer",
            "onsails/lspkind-nvim",
            "simrat39/rust-tools.nvim",
            "nvim-lua/lsp-status.nvim",
            "mfussenegger/nvim-jdtls",
            -- "tami5/lspsaga.nvim",
            -- "btstream/nvim-dotnvim",
            "ray-x/lsp_signature.nvim",
            "tamago324/nlsp-settings.nvim",
        },
        config = function()
            require("plugins.settings.lsp")
        end,
    })

    use({ -- outline
        "simrat39/symbols-outline.nvim",
        config = function()
            require("plugins.settings.symbols_outline")
        end,
    })

    use({ -- null-ls
        "jose-elias-alvarez/null-ls.nvim",
        requires = { "nvim-lua/plenary.nvim" },
        config = function()
            require("plugins.settings.lsp.providers.null_ls")
        end,
    })

    -- cmp
    use({
        "hrsh7th/nvim-cmp",
        requires = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-vsnip",
            "hrsh7th/vim-vsnip",
            "windwp/nvim-autopairs",
            "rafamadriz/friendly-snippets",
        },
        config = function()
            require("plugins.settings.cmp")
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

    -- colorizer
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
        cond = function()
            return vim.g.statusline == "galaxyline"
        end,
        config = function()
            require("plugins.settings.statusline.galaxyline").setup()
        end,
    })

    use({
        "nvim-lualine/lualine.nvim",
        requires = { "kyazdani42/nvim-web-devicons", opt = true },
        cond = function()
            return vim.g.statusline == "lualine"
        end,
        config = function()
            require("plugins.settings.statusline.lualine")
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
        ft = { "markdown" },
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

    -- suda
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

    -- editorconfig
    use({ "editorconfig/editorconfig-vim" })

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAPG then
        print("First install")
        require("packer").sync()
    end
end)
