local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- add packer itself to packer manager, to avoid remove
    -- "wbthomason/packer.nvim",

    -- "dstein64/vim-startuptime",

    -- use({
    --     "lewis6991/impatient.nvim",
    --     config = [[require('impatient').enable_profile()]],
    -- })
    ----------------------------------------------------------------------
    --                                UI                                --
    ----------------------------------------------------------------------

    "RRethy/nvim-base16",

    {
        "rcarriga/nvim-notify",
        event = "VeryLazy",
        config = function()
            vim.notify = require("notify")
        end,
    },

    -- dressing
    {
        "stevearc/dressing.nvim",
        event = "VeryLazy",
        config = function()
            require("plugins.settings.dressing")
        end,
    },

    -- dashboard
    {
        "glepnir/dashboard-nvim",
        -- event = "VeryLazy",
        config = function()
            require("plugins.settings.dashboard")
        end,
    },

    -- nvim-tree
    {
        "kyazdani42/nvim-tree.lua",
        dependencies = "kyazdani42/nvim-web-devicons",
        event = "VeryLazy",
        -- cmd = "NvimTree*",
        config = function()
            require("plugins.settings.nvim_tree")
        end,
    },

    ----------------------------------------------------------------------
    --                          Config for LSP                          --
    ----------------------------------------------------------------------

    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPost", "BufNew", "BufNewFile" },
        -- wants = { "lsp-status.nvim", "nvim-jdtls", "nlsp-settings.nvim", "lspkind-nvim", "cmp-nvim-lsp" },
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",
            "simrat39/rust-tools.nvim",
            "mfussenegger/nvim-jdtls",
            "tamago324/nlsp-settings.nvim",
            "onsails/lspkind-nvim",
        },

        config = function()
            require("plugins.settings.lsp")
        end,
    },

    -- trouble
    {
        "folke/trouble.nvim",
        event = "LspAttach",
        dependencies = "kyazdani42/nvim-web-devicons",
        config = function()
            require("plugins.settings.trouble")
        end,
    },

    {
        "kosayoda/nvim-lightbulb",
        dependencies = "antoinemadec/FixCursorHold.nvim",
        event = "LspAttach",
        config = function()
            require("plugins.settings.lightbulb")
        end,
    },

    { -- outline
        "simrat39/symbols-outline.nvim",
        event = "LspAttach",
        config = function()
            require("plugins.settings.symbols_outline")
        end,
    },

    { -- null-ls
        "jose-elias-alvarez/null-ls.nvim",
        dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
        event = "BufReadPost",
        -- wants = { "nvim-lspconfig" },
        config = function()
            require("plugins.settings.lsp.providers.null_ls")
        end,
    },

    ----------------------------------------------------------------------
    --                            Config cmp                            --
    ----------------------------------------------------------------------

    -- local cmps = {
    --     "hrsh7th/cmp-nvim-lua",
    --     "hrsh7th/cmp-nvim-lsp-signature-help",
    --     "hrsh7th/cmp-buffer",
    --     "hrsh7th/cmp-cmdline",
    --     "hrsh7th/cmp-path",
    --     "hrsh7th/cmp-vsnip",
    --     "hrsh7th/vim-vsnip",
    --     "rafamadriz/friendly-snippets",
    -- }
    -- for _, v in ipairs(cmps) do
    --     use({
    --         v,
    --         after = "nvim-cmp",
    --     })
    -- end

    -- { "hrsh7th/cmp-nvim-lsp", wants = "nvim-cmp" },

    -- {
    --     "windwp/nvim-autopairs",
    --     lazy = true,
    -- },

    {
        "hrsh7th/nvim-cmp",
        event = { "BufRead", "CmdlineEnter" },
        -- wants = { "lspkind-nvim", "nvim-autopairs" },
        dependencies = {
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-vsnip",
            "hrsh7th/vim-vsnip",
            "windwp/nvim-autopairs",
            "rafamadriz/friendly-snippets",
        },
        config = function()
            require("plugins.settings.cmp")
        end,
    },

    ----------------------------------------------------------------------
    --                               DAP                                --
    ----------------------------------------------------------------------

    {
        "mfussenegger/nvim-dap",
        event = "LspAttach",
        dependencies = {
            "theHamsta/nvim-dap-virtual-text",
            "rcarriga/nvim-dap-ui",
            "mfussenegger/nvim-dap-python",
        },
        -- wants = { "nvim-dap-virtual-text", "nvim-dap-ui", "nvim-dap-python" },
        -- keys = { "<F6>" },
        config = function()
            require("plugins.settings.dap")
        end,
    },

    ----------------------------------------------------------------------
    --                       Status and buffline                        --
    ----------------------------------------------------------------------
    {
        "nvim-lualine/lualine.nvim",
        event = "BufWinEnter",
        dependencies = {
            "kyazdani42/nvim-web-devicons",
            "arkav/lualine-lsp-progress",
        },
        config = function()
            require("plugins.settings.lualine")
        end,
    },

    {
        "akinsho/bufferline.nvim",
        dependencies = { "kyazdani42/nvim-web-devicons" },
        event = "BufRead",
        config = function()
            require("plugins.settings.bufferline")
        end,
    },

    {
        "SmiteshP/nvim-navic",
        event = "LspAttach",
        dependencies = "neovim/nvim-lspconfig",
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
    },

    -- which-key
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        config = function()
            require("which-key").setup({ window = { border = "solid" } })
        end,
    },

    ----------------------------------------------------------------------
    --                             Terminal                             --
    ----------------------------------------------------------------------
    {
        "akinsho/toggleterm.nvim",
        config = function()
            require("plugins.settings.terminal")
        end,
        keys = { "<C-k>t", "<C-k>g" },
    },

    ----------------------------------------------------------------------
    --                            Telescope                             --
    ----------------------------------------------------------------------
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-ui-select.nvim",
            "nvim-telescope/telescope-file-browser.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make", lazy = true },
            {
                "ahmedkhalf/project.nvim",
                -- wants = "telescope.nvim",
                lazy = true,
                config = function()
                    require("plugins.settings.project")
                end,
            },
        },
        -- cmd = "Telescope",
        event = "VeryLazy",
        config = function()
            require("plugins.settings.telescope")
        end,
    },

    ----------------------------------------------------------------------
    --                             Comments                             --
    ----------------------------------------------------------------------
    {
        "numToStr/Comment.nvim",
        config = function()
            require("plugins.settings.comments")
        end,
        keys = { "gcc", { mode = "v", "gc" } },
    },

    {
        "danymat/neogen",
        config = function()
            require("plugins.settings.neogen")
        end,
        -- wants = "nvim-treesitter",
        dependencies = "nvim-treesitter/nvim-treesitter",
        keys = { "<leader>nf", "<leader>nc" },
    },

    {
        "s1n7ax/nvim-comment-frame",
        dependencies = "nvim-treesitter/nvim-treesitter",
        config = function()
            require("plugins.settings.nvim_comment_frame")
        end,
        keys = { "<leader>cC", "<leader>cc", { mode = "i", "<C-k>c" }, { mode = "i", "<C-k>C" } },
    },

    {
        "folke/todo-comments.nvim",
        dependencies = "nvim-lua/plenary.nvim",
        event = "VeryLazy",
        -- cmd = "Todo*",
        config = function()
            require("plugins.settings.todo_comments")
        end,
    },

    ----------------------------------------------------------------------
    --                            Git Tools                             --
    ----------------------------------------------------------------------
    {
        "lewis6991/gitsigns.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        event = "BufRead",
        config = function()
            require("plugins.settings.gitsigns")
        end,
    },

    ----------------------------------------------------------------------
    --                             Edit Enhencement                     --
    ----------------------------------------------------------------------

    -- colorizer
    {
        "norcalli/nvim-colorizer.lua",
        event = "BufRead",
        config = function()
            require("colorizer").setup({
                "*",
                "!packer",
            })
        end,
    },

    -- nvim treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = "BufRead",
        -- wants = { "nvim-ts-rainbow" },
        dependencies = "p00f/nvim-ts-rainbow",
        config = function()
            require("plugins.settings.treesitter")
        end,
    },

    -- -- indent line
    {
        "lukas-reineke/indent-blankline.nvim",
        event = "BufRead",
        -- wants = "nvim-treesitter",
        dependencies = "nvim-treesitter/nvim-treesitter",
        config = function()
            require("plugins.settings.indent_line")
        end,
    },

    {
        "rlue/vim-barbaric",
        cond = function()
            return vim.fn.has("win32") == 0
        end,
        -- keys = { { "i", "<Esc>" } },
        event = "BufRead",
        config = function()
            require("plugins.settings.barbaric")
        end,
    },

    {
        "Vonr/align.nvim",
        event = "BufRead",
        config = function()
            require("plugins.settings.align")
        end,
    },

    -- -- suda
    {
        "lambdalisue/suda.vim",
        -- bufread = true,
        envent = "VeryLazy",
        config = function()
            vim.g.suda_smart_edit = 1
        end,
    },

    -- markdown preview
    {
        "iamcco/markdown-preview.nvim",
        build = function()
            vim.cmd("call mkdp#util#install()")
        end,
        ft = { "markdown" },
    },

    -- -- editorconfig
    { "editorconfig/editorconfig-vim", event = "VeryLazy" },

    {
        "kevinhwang91/nvim-ufo",
        dependencies = { "kevinhwang91/promise-async", "nvim-treesitter/nvim-treesitter" },
        -- wants = { "nvim-treesitter" },
        event = { "BufRead", "BufNew", "BufNewFile" },
        config = function()
            require("plugins.settings.ufo")
        end,
    },

    ----------------------------------------------------------------------
    --                        Runcode and others                        --
    ----------------------------------------------------------------------

    -- SnipR
    {
        "michaelb/sniprun",
        build = "bash ./install.sh",
        cond = function() -- only load on macos and linux
            return vim.fn.has("win32") == 0
        end,
        event = "LspAttach",
        config = function()
            require("plugins.settings.sniprun")
        end,
    },

    -- rest tools
    {
        "NTBBloodbath/rest.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        ft = "http",
        config = function()
            require("plugins.settings.rest_nvim")
        end,
    },

    {
        "romainl/vim-cool",
        event = "BufRead",
    },
})
