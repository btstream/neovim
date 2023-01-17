return {
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
        dependencies = "nvim-tree/nvim-web-devicons",
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
}
