local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAPG = vim.fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
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

-- Have packer use a popup window
packer.init({
    display = {
        open_fn = function()
            local status, win, buf = require("packer.util").float({ border = "rounded" })
            vim.api.nvim_win_set_option(
                win,
                "winhighlight",
                "NormalFloat:PackerFloatNormal,FloatBorder:PackerFloatBorder,EndOfBuffer:PackerFloatNormal"
            )
            return status, win, buf
        end,
    },
    -- git = {
    --     default_url_format = "https://hub.fastgit.xyz/%s",
    -- },
})

packer.startup({
    function(use)
        -- add packer itself to packer manager, to avoid remove
        use("wbthomason/packer.nvim")
        -- use({
        --     "lewis6991/impatient.nvim",
        --     config = function()
        --         require("impatient")
        --     end,
        -- })

        -- themes
        -- use({
        --     "xiyaowong/nvim-transparent",
        --     cond = function()
        --         return require("settings").theme.transparent
        --     end,
        -- })
        -- use("marko-cerovac/material.nvim")
        -- use("rmehri01/onenord.nvim")
        -- use("navarasu/onedarkpro.nvim")
        use("RRethy/nvim-base16")

        use({
            "rcarriga/nvim-notify",
            config = function()
                vim.notify = require("notify")
            end,
        })

        ----------------------------------------------------------------------
        --                          Config for LSP                          --
        ----------------------------------------------------------------------

        use({
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",
        })

        use({
            "onsails/lspkind-nvim",
            -- event = "BufWinEnter",
        })

        use({
            "simrat39/rust-tools.nvim",
            event = "BufReadPost",
        })

        use({
            "mfussenegger/nvim-jdtls",
            event = "BufReadPost",
        })

        use({
            "tamago324/nlsp-settings.nvim",
            -- opt = true,
            event = "BufReadPost",
        })

        use({
            "nvim-lua/lsp-status.nvim",
            event = "BufWinEnter",
            config = function()
                require("lsp-status").config({})
            end,
            -- opt = true,
        })

        use({
            "neovim/nvim-lspconfig",
            requires = {
                -- "williamboman/nvim-lsp-installer",
            },
            after = { "nlsp-settings.nvim", "lsp-status.nvim", "cmp-nvim-lsp" },
            event = "BufReadPost",
            config = function()
                require("plugins.settings.lsp")
            end,
        })

        -- trouble
        use({
            "folke/trouble.nvim",
            event = "LspAttach",
            requires = "kyazdani42/nvim-web-devicons",
            config = function()
                require("plugins.settings.trouble")
            end,
        })

        use({ -- outline
            "simrat39/symbols-outline.nvim",
            event = "LspAttach",
            config = function()
                require("plugins.settings.symbols_outline")
            end,
        })

        use({ -- null-ls
            "jose-elias-alvarez/null-ls.nvim",
            requires = { "nvim-lua/plenary.nvim" },
            event = "BufReadPost",
            after = { "lsp-status.nvim", "nvim-lspconfig" },
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
                "hrsh7th/cmp-nvim-lsp-signature-help",
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-cmdline",
                "hrsh7th/cmp-path",
                "hrsh7th/cmp-vsnip",
                "hrsh7th/vim-vsnip",
                "rafamadriz/friendly-snippets",
                -- "f3fora/cmp-spell",
                "windwp/nvim-autopairs",
            },
            -- event = "BufWinEnter",
            -- after = { "lspkind-nvim" },
            config = function()
                require("plugins.settings.cmp")
            end,
        })

        -- dap
        use({ "theHamsta/nvim-dap-virtual-text", event = "LspAttach" })
        use({ "rcarriga/nvim-dap-ui", event = "LspAttach" })
        use({
            "mfussenegger/nvim-dap",
            event = "LspAttach",
            config = function()
                require("plugins.settings.dap")
            end,
        })

        -- colorizer
        use({
            "norcalli/nvim-colorizer.lua",
            event = "BufWinEnter",
            config = function()
                require("colorizer").setup({
                    "*",
                    "!packer",
                })
            end,
        })

        -- nvim treesitter
        use({
            "nvim-treesitter/nvim-treesitter",
            run = ":TSUpdate",
            event = "BufWinEnter",
            -- after = "nvim-ts-rainbow",
            config = function()
                require("plugins.settings.treesitter")
            end,
        })
        use({ "p00f/nvim-ts-rainbow", opt = true })

        -- indent line
        use({
            "lukas-reineke/indent-blankline.nvim",
            event = "BufWinEnter",
            after = "nvim-treesitter",
            config = function()
                require("plugins.settings.indent_line")
            end,
        })

        -- status line and tabbar
        use({
            "nvim-lualine/lualine.nvim",
            event = "BufWinEnter",
            requires = { "kyazdani42/nvim-web-devicons", opt = true },
            config = function()
                require("plugins.settings.lualine")
            end,
        })

        use({
            "akinsho/bufferline.nvim",
            requires = { "kyazdani42/nvim-web-devicons" },
            event = "BufWinEnter",
            config = function()
                require("plugins.settings.bufferline")
            end,
        })

        use({
            "SmiteshP/nvim-navic",
            event = "LspAttach",
            requires = "neovim/nvim-lspconfig",
            config = function()
                local navic_icons = {}
                for k, v in ipairs(require("themes.icons").lsp_symbol_icons) do
                    navic_icons[k] = (" %s "):format(v)
                end
                require("nvim-navic").setup({
                    highlight = true,
                    separator = " › ",
                    icons = navic_icons,
                })
            end,
        })

        -- which-key
        use({
            "folke/which-key.nvim",
            event = "BufWinEnter",
            config = function()
                require("which-key").setup({ window = { border = "solid" } })
            end,
        })

        -- terminal
        use({
            "akinsho/toggleterm.nvim",
            config = function()
                require("plugins.settings.terminal")
            end,
            keys = { "<C-k>t", "<C-k>g" },
        })

        -- telescope
        use({
            "nvim-telescope/telescope.nvim",
            requires = {
                "nvim-lua/plenary.nvim",
                "nvim-telescope/telescope-ui-select.nvim",
                { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
            },
            cmd = "Telescope",
            config = function()
                require("plugins.settings.telescope")
            end,
        })

        use({
            "nvim-telescope/telescope-file-browser.nvim",
            after = "telescope.nvim",
            config = function()
                require("plugins.settings.file_explorer")
            end,
        })

        -- dressing
        use({
            "stevearc/dressing.nvim",
            config = function()
                require("plugins.settings.dressing")
            end,
        })

        -- dashboard
        use({
            "glepnir/dashboard-nvim",
            event = "BufWinEnter",
            config = function()
                require("plugins.settings.dashboard")
            end,
        })

        -- nvim-tree
        use({
            "kyazdani42/nvim-tree.lua",
            requires = "kyazdani42/nvim-web-devicons",
            cmd = "NvimTree*",
            config = function()
                require("plugins.settings.nvim_tree")
            end,
        })

        -- project
        use({
            "ahmedkhalf/project.nvim",
            -- after = "telescope.nvim",
            event = "BufWinEnter",
            config = function()
                require("plugins.settings.project")
            end,
        })

        -- comments
        use({
            "numToStr/Comment.nvim",
            -- event = "BufWinEnter",
            -- tag = "v0.6",
            config = function()
                require("plugins.settings.comments")
            end,
            keys = { "gcc" },
        })

        use({
            "danymat/neogen",
            -- event = "BufWinEnter",
            config = function()
                require("neogen").setup({ enabled = true })
            end,
            after = "nvim-treesitter",
            kyes = { "<leader>cC", "<leader>cc", { "i", "<C-k>c" }, { "i", "<C-k>C" } },
        })

        use({
            "s1n7ax/nvim-comment-frame",
            -- requires = {
            --     { "nvim-treesitter" },
            -- event = "BufRead",
            after = "nvim-treesitter",
            config = function()
                require("plugins.settings.nvim_comment_frame")
            end,
        })

        use({
            "folke/todo-comments.nvim",
            requires = "nvim-lua/plenary.nvim",
            cmd = "Todo*",
            config = function()
                require("plugins.settings.todo_comments")
            end,
        })

        -- gitsigns
        use({
            "lewis6991/gitsigns.nvim",
            requires = { "nvim-lua/plenary.nvim" },
            event = "BufWinEnter",
            config = function()
                require("gitsigns").setup()
            end,
        })

        -- git-blame
        use({
            "f-person/git-blame.nvim",
            event = "BufWinEnter",
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
            cond = function() -- only load on macos and linux
                return vim.fn.has("win32") == 0
            end,
            event = "LspAttach",
            config = function()
                require("plugins.settings.sniprun")
            end,
        })

        -- suda
        use({
            "lambdalisue/suda.vim",
            -- event = "FileChangedRO",
            config = function()
                vim.g.suda_smart_edit = 1
            end,
        })

        -- rest tools
        use({
            "NTBBloodbath/rest.nvim",
            requires = { "nvim-lua/plenary.nvim" },
            ft = "http",
            config = function()
                require("plugins.settings.rest_nvim")
            end,
        })

        -- editorconfig
        use({ "editorconfig/editorconfig-vim" })

        -- Automatically set up your configuration after cloning packer.nvim
        -- Put this at the end after all plugins
        if PACKER_BOOTSTRAPG then
            require("packer").sync()
        end
    end,
    config = {
        profile = {
            enable = true,
        },
    },
})
