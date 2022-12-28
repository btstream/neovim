local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if vim.fn.has("win32") == 1 then
    install_path = string.gsub(install_path, "/", "\\\\")
end

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

        use("dstein64/vim-startuptime")

        use({
            "lewis6991/impatient.nvim",
            config = [[require('impatient').enable_profile()]],
        })
        ----------------------------------------------------------------------
        --                                UI                                --
        ----------------------------------------------------------------------

        use("RRethy/nvim-base16")

        use({
            "rcarriga/nvim-notify",
            config = function()
                vim.notify = require("notify")
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

        ----------------------------------------------------------------------
        --                          Config for LSP                          --
        ----------------------------------------------------------------------

        local lsp_addons = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",
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

        -- use({
        --     "nvim-lua/lsp-status.nvim",
        --     config = function()
        --         require("lsp-status").config({})
        --     end,
        --     opt = true,
        -- })

        use({
            "neovim/nvim-lspconfig",
            event = { "BufReadPost", "BufNew", "BufNewFile" },
            -- wants = { "lsp-status.nvim", "nvim-jdtls", "nlsp-settings.nvim", "lspkind-nvim", "cmp-nvim-lsp" },
            wants = {
                "nvim-jdtls",
                "rust-tools.nvim",
                "nlsp-settings.nvim",
                "lspkind-nvim",
                "cmp-nvim-lsp",
                "mason.nvim",
                "mason-lspconfig.nvim",
                "mason-tool-installer.nvim",
            },
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

        use({
            "kosayoda/nvim-lightbulb",
            -- requires = "antoinemadec/FixCursorHold.nvim",
            event = "LspAttach",
            config = [[require("plugins.settings.lightbulb")]],
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
            after = { "nvim-lspconfig" },
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

        ----------------------------------------------------------------------
        --                               DAP                                --
        ----------------------------------------------------------------------

        use({
            "mfussenegger/nvim-dap",
            event = "LspAttach",
            requires = {
                { "theHamsta/nvim-dap-virtual-text", opt = "true" },
                { "rcarriga/nvim-dap-ui", opt = "true" },
                { "mfussenegger/nvim-dap-python", opt = "true" },
            },
            wants = { "nvim-dap-virtual-text", "nvim-dap-ui", "nvim-dap-python" },
            -- keys = { "<F6>" },
            config = function()
                require("plugins.settings.dap")
            end,
        })

        ----------------------------------------------------------------------
        --                       Status and buffline                        --
        ----------------------------------------------------------------------
        use({
            "nvim-lualine/lualine.nvim",
            event = "BufWinEnter",
            requires = { "kyazdani42/nvim-web-devicons", opt = true },
            wants = "lualine-lsp-progress",
            config = function()
                require("plugins.settings.lualine")
            end,
        })

        use({
            "arkav/lualine-lsp-progress",
            opt = true,
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

        ----------------------------------------------------------------------
        --                             Terminal                             --
        ----------------------------------------------------------------------
        use({
            "akinsho/toggleterm.nvim",
            config = function()
                require("plugins.settings.terminal")
            end,
            keys = { "<C-k>t", "<C-k>g" },
        })

        ----------------------------------------------------------------------
        --                            Telescope                             --
        ----------------------------------------------------------------------
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
            event = "LspAttach",
            config = function()
                require("plugins.settings.telescope")
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

        ----------------------------------------------------------------------
        --                             Comments                             --
        ----------------------------------------------------------------------
        use({
            "numToStr/Comment.nvim",
            config = function()
                require("plugins.settings.comments")
            end,
            keys = { "gcc", { "v", "gc" } },
        })

        use({
            "danymat/neogen",
            config = function()
                require("plugins.settings.neogen")
            end,
            after = "nvim-treesitter",
            keys = { "<leader>nf", "<leader>nc" },
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
            kyes = { "<leader>cC", "<leader>cc", { "i", "<C-k>c" }, { "i", "<C-k>C" } },
        })

        use({
            "folke/todo-comments.nvim",
            requires = "nvim-lua/plenary.nvim",
            cmd = "Todo*",
            config = function()
                require("plugins.settings.todo_comments")
            end,
        })

        ----------------------------------------------------------------------
        --                            Git Tools                             --
        ----------------------------------------------------------------------
        use({
            "lewis6991/gitsigns.nvim",
            requires = { "nvim-lua/plenary.nvim" },
            event = "BufRead",
            config = function()
                require("plugins.settings.gitsigns")
            end,
        })

        ----------------------------------------------------------------------
        --                             Edit Enhencement                     --
        ----------------------------------------------------------------------

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

        use({
            "rlue/vim-barbaric",
            cond = function()
                return vim.fn.has("win32") == 0
            end,
            -- keys = { { "i", "<Esc>" } },
            event = "BufRead",
            config = function()
                require("plugins.settings.barbaric")
            end,
        })

        use({ "Vonr/align.nvim", event = "BufRead", config = [[require("plugins.settings.align")]] })

        -- suda
        use({
            "lambdalisue/suda.vim",
            bufread = true,
            config = function()
                vim.g.suda_smart_edit = 1
            end,
        })

        -- markdown preview
        use({
            "iamcco/markdown-preview.nvim",
            run = function()
                vim.cmd("call mkdp#util#install()")
            end,
            ft = { "markdown" },
        })

        -- editorconfig
        use({ "editorconfig/editorconfig-vim" })

        use({
            "kevinhwang91/nvim-ufo",
            requires = "kevinhwang91/promise-async",
            wants = { "nvim-treesitter" },
            event = { "BufRead", "BufNew", "BufNewFile" },
            config = function()
                require("plugins.settings.ufo")
            end,
        })

        ----------------------------------------------------------------------
        --                        Runcode and others                        --
        ----------------------------------------------------------------------

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

        -- rest tools
        use({
            "NTBBloodbath/rest.nvim",
            requires = { "nvim-lua/plenary.nvim" },
            ft = "http",
            config = function()
                require("plugins.settings.rest_nvim")
            end,
        })

        use({
            "romainl/vim-cool",
            event = "BufRead",
        })

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
