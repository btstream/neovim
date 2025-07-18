return {
    {
        "neovim/nvim-lspconfig",
        event = { "User BufReadReadFilePostDefer" },
        dependencies = {
            "mason-org/mason.nvim",
            "mason-org/mason-lspconfig.nvim",
            "creativenull/efmls-configs-nvim",
            "simrat39/rust-tools.nvim",
            "mfussenegger/nvim-jdtls",
            -- "tamago324/nlsp-settings.nvim",
            "onsails/lspkind-nvim",
        },
        config = function()
            require("plugins.lsp.base")
            require("plugins.lsp.diagostics")
        end,
    },

    {
        "mason-org/mason.nvim",
        event = "User VeryVeryLazy",
        dependencies = { "WhoIsSethDaniel/mason-tool-installer.nvim" },
        build = function()
            require("plugins.lsp.mason")
        end,
        config = function()
            require("plugins.lsp.mason")
        end,
    },

    {
        -- TODO:waiting update for main repo "kosayoda/nvim-lightbulb",
        "kosayoda/nvim-lightbulb",
        dependencies = "antoinemadec/FixCursorHold.nvim",
        event = "LspAttach",
        config = function()
            -- vim.fn.sign_define("LightBulbSign", { text = "", texthl = "LightBulbSign" })

            require("nvim-lightbulb").setup({
                sign = {
                    text = "",
                    enabled = true,
                    priority = 30,
                    hl = "LightBulbSign",
                },
                autocmd = {
                    enabled = true,
                    -- see :help autocmd-pattern
                    pattern = { "*" },
                    -- see :help autocmd-events
                    events = { "CursorHold", "CursorHoldI" },
                },
                ignore = {
                    clients = { "null-ls" },
                },
            })
        end,
    },

    {
        "hedyhli/outline.nvim",
        -- "btstream/outline.nvim",
        -- event = "LspAttach",
        dependencies = {
            'epheien/outline-treesitter-provider.nvim'
        },
        cmd = { "Outline", "OutlineOpen" },
        keys = { -- Example mapping to toggle outline
            { "<C-k>o", "<cmd>Outline<CR>", desc = "Toggle outline" },
        },
        config = function()
            local symbol_icons = {}
            for k, v in pairs(require("themes.icons").lsp_symbols) do
                symbol_icons[k] = { icon = v }
            end
            require("outline").setup({
                providers = {
                    priority = { 'lsp', 'treesitter' },
                },
                outline_window = {
                    width = 18,
                },
                preview_window = {
                    winhl = "NormalFloat:OutlinePreviewNormal",
                },
                symbols = {
                    icons = symbol_icons,
                },
            })
        end,
    },

    -- python-type-stubs
    {
        "microsoft/python-type-stubs",
        cond = function()
            local path = require("utils.os.path")
            local lazypath = path.join(vim.fn.stdpath("data"), "lazy", "python-type-stubs")
            return not path.exists(lazypath)
        end,
    },
}
