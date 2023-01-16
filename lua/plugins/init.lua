vim.api.nvim_create_autocmd({ "BufReadPost", "BufNew", "BufNewFile" }, {
    group = vim.api.nvim_create_augroup("CustomBufRead", { clear = true }),
    callback = function()
        if not require("plugins.settings.lualine.utils.filetype_tools").is_nonefiletype() then
            vim.cmd([[do User BufReadRealFile]])
        end
    end,
})

return {
    -- add packer itself to packer manager, to avoid remove
    "folke/lazy.nvim",

    -- "dstein64/vim-startuptime",

    ----------------------------------------------------------------------
    --                                UI                                --
    ----------------------------------------------------------------------

    {
        "RRethy/nvim-base16",
        config = function()
            require("theme")
        end,
    },

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
        event = "VimEnter",
        config = function()
            require("plugins.settings.dashboard")
        end,
    },

    -- nvim-tree
    {
        "kyazdani42/nvim-tree.lua",
        dependencies = "kyazdani42/nvim-web-devicons",
        cmd = "NvimTreeToggle",
        config = function()
            require("plugins.settings.nvim_tree")
        end,
    },

    ----------------------------------------------------------------------
    --                          Config for LSP                          --
    ----------------------------------------------------------------------

    {
        "neovim/nvim-lspconfig",
        event = "User BufReadRealFile",
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
        event = "User BufReadRealFile",
        -- wants = { "nvim-lspconfig" },
        config = function()
            require("plugins.settings.lsp.providers.null_ls")
        end,
    },

    ----------------------------------------------------------------------
    --                            Config cmp                            --
    ----------------------------------------------------------------------

    {
        "hrsh7th/nvim-cmp",
        event = { "InsertEnter", "CmdlineEnter" },
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
        config = function()
            require("plugins.settings.dap")
        end,
    },

    ----------------------------------------------------------------------
    --                       Status and buffline                        --
    ----------------------------------------------------------------------
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
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
        name = "bufferline",
        dependencies = { "kyazdani42/nvim-web-devicons" },
        event = "User BufReadRealFile",
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
            vim.g.navic_loaded = true
            require("nvim-navic").setup({
                highlight = true,
                separator = " › ",
                icons = navic_icons,
            })
        end,
    },

    ----------------------------------------------------------------------
    --                            Which Key                             --
    ----------------------------------------------------------------------
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
                lazy = true,
                config = function()
                    require("plugins.settings.project")
                end,
            },
        },
        cmd = "Telescope",
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
        keys = { mode = { "n", "i" }, "<C-k>T" },
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
        event = "User BufReadRealFile",
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
        event = "User BufReadRealFile",
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
        event = "User BufReadRealFile",
        dependencies = { "mrjones2014/nvim-ts-rainbow" },
        config = function()
            require("plugins.settings.treesitter")
        end,
    },

    -- indent line
    {
        "lukas-reineke/indent-blankline.nvim",
        event = "User BufReadRealFile",
        dependencies = "nvim-treesitter/nvim-treesitter",
        config = function()
            require("plugins.settings.indent_line")
        end,
    },

    -- fold
    {
        "kevinhwang91/nvim-ufo",
        enabled = true,
        dependencies = { "kevinhwang91/promise-async", "nvim-treesitter/nvim-treesitter" },
        event = "User BufReadRealFile",
        config = function()
            require("plugins.settings.ufo")
        end,
    },

    {
        "rlue/vim-barbaric",
        cond = function()
            return vim.fn.has("win32") == 0
        end,
        event = "User BufReadRealFile",
        config = function()
            require("plugins.settings.barbaric")
        end,
    },

    {
        "Vonr/align.nvim",
        event = "User BufReadRealFile",
        config = function()
            require("plugins.settings.align")
        end,
    },

    -- search
    {
        "romainl/vim-cool",
        event = "SearchWrapped",
    },

    -- suda
    {
        "lambdalisue/suda.vim",
        -- bufread = true,
        event = "VeryLazy",
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
}
