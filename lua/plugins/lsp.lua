return {
    {
        "neovim/nvim-lspconfig",
        event = { "User BufReadReadFilePostDefer" },
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "simrat39/rust-tools.nvim",
            "mfussenegger/nvim-jdtls",
            "tamago324/nlsp-settings.nvim",
            "onsails/lspkind-nvim",
        },
        config = function()
            require("plugins.settings.lsp")
        end,
    },

    {
        "williamboman/mason.nvim",
        event = "User VeryVeryLazy",
        dependencies = { "WhoIsSethDaniel/mason-tool-installer.nvim" },
        build = function()
            require("plugins.settings.lsp.mason")
        end,
        config = function()
            require("plugins.settings.lsp.mason")
        end,
    },

    {
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
            })
        end,
    },

    -- { -- outline
    --     "simrat39/symbols-outline.nvim",
    --     event = "LspAttach",
    --     config = function()
    --         local symbols = {}
    --         for k, v in pairs(require("themes.icons").lsp_symbols) do
    --             symbols[k] = { icon = v }
    --         end

    --         require("symbols-outline").setup({
    --             highlight_hovered_item = true,
    --             show_guides = true,
    --             auto_preview = false,
    --             relative_width = false,
    --             position = "right",
    --             width = 40,
    --             show_numbers = false,
    --             show_relative_numbers = false,
    --             show_symbol_details = true,
    --             preview_bg_highlight = "NormalFloat",
    --             keymaps = { -- These keymaps can be a string or a table for multiple keys
    --                 close = { "<Esc>", "q" },
    --                 goto_location = "<Cr>",
    --                 focus_location = "o",
    --                 hover_symbol = "<C-space>",
    --                 toggle_preview = "K",
    --                 rename_symbol = "r",
    --                 code_actions = "a",
    --             },
    --             lsp_blacklist = {},
    --             symbol_blacklist = {},
    --             symbols = symbols,
    --         })

    --         local map = vim.keymap.set
    --         map("n", "<C-k>o", "<cmd>SymbolsOutline<cr>")
    --     end,
    -- },

    { -- null-ls
        "jose-elias-alvarez/null-ls.nvim",
        dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
        event = { "User BufReadReadFilePostDefer" },
        config = function()
            require("plugins.settings.lsp.providers.null_ls")
        end,
    },

    -- python-type-stubs
    {
        "microsoft/python-type-stubs",
        cond = false,
    },
}
