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

        local lsp_addons = {
            "simrat39/rust-tools.nvim",
            "mfussenegger/nvim-jdtls",
            "tamago324/nlsp-settings.nvim",
            "onsails/lspkind-nvim",
        }

        for _, l in ipairs(lsp_addons) do
            use({
                l,
                -- event = "BufReadPost",
                opt = true,
            })
        end

        use({
            "nvim-lua/lsp-status.nvim",
            config = function()
                require("lsp-status").config({})
            end,
            opt = true,
        })

        use({
            "neovim/nvim-lspconfig",
            event = "BufReadPost",
            wants = { "lsp-status.nvim", "nvim-jdtls", "nlsp-settings.nvim", "lspkind-nvim", "cmp-nvim-lsp" },
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

        ----------------------------------------------------------------------
        --                            Config cmp                            --
        ----------------------------------------------------------------------

        local cmps = {
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-vsnip",
            "hrsh7th/vim-vsnip",
            "rafamadriz/friendly-snippets",
        }
        for _, v in ipairs(cmps) do
            use({
                v,
                after = "nvim-cmp",
            })
        end

        use({ "hrsh7th/cmp-nvim-lsp", wants = "nvim-cmp" })

        use({
            "windwp/nvim-autopairs",
            opt = true,
        })

        use({
            "hrsh7th/nvim-cmp",
            event = { "BufRead", "CmdlineEnter" },
            wants = { "lspkind-nvim", "nvim-autopairs" },
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
            event = "BufRead",
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
            event = "BufRead",
            -- wants = { "nvim-ts-rainbow" },
            config = function()
                require("plugins.settings.treesitter")
            end,
        })
        use({ "p00f/nvim-ts-rainbow", opt = true })

        -- indent line
        use({
            "lukas-reineke/indent-blankline.nvim",
            event = "BufRead",
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
            event = "BufRead",
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
                { "nvim-telescope/telescope-ui-select.nvim", opt = true },
                { "nvim-telescope/telescope-file-browser.nvim", opt = true },
                { "nvim-telescope/telescope-fzf-native.nvim", run = "make", opt = true },
            },
            wants = {
                "project.nvim",
                "telescope-ui-select.nvim",
                "telescope-file-browser.nvim",
                "telescope-fzf-native.nvim",
            },
            cmd = "Telescope",
            config = function()
                require("plugins.settings.telescope")
            end,
        })

        -- use({
        --     after = "telescope.nvim",
        --     cmd = "Telescope",
        --     config = function()
        --         require("plugins.settings.file_explorer")

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
            event = "BufRead",
            config = function()
                require("plugins.settings.project")
            end,
        })

        -- comments
        use({
            "numToStr/Comment.nvim",
            config = function()
                require("plugins.settings.comments")
            end,
            keys = { "gcc", { "v", "gc" } },
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
            keys = { "<leader>nf", "<leader>nc" },
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
            event = "BufRead",
            config = function()
                require("gitsigns").setup()
            end,
        })

        -- git-blame
        use({
            "f-person/git-blame.nvim",
            event = "BufRead",
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
            event = "BufRead",
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
