return {
    "btstream/avante.nvim",
    -- dir = "~/Development/projects_for_opensource/avante.nvim/",
    -- dev = true,
    event = { "User BufReadRealFile" },
    version = false, -- Never set this value to "*"! Never!
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        -- "stevearc/dressing.nvim",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        --- The below dependencies are optional,
        -- "echasnovski/mini.pick",         -- for file_selector provider mini.pick
        -- "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
        "hrsh7th/nvim-cmp",            -- autocompletion for avante commands and mentions
        -- "ibhagwan/fzf-lua",              -- for file_selector provider fzf
        "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
        -- "zbirenbaum/copilot.lua",      -- for providers='copilot'
        "OXY2DEV/markview.nvim",
        {
            -- support for image pasting
            "HakonHarnes/img-clip.nvim",
            event = "VeryLazy",
            opts = {
                -- recommended settings
                default = {
                    embed_image_as_base64 = false,
                    prompt_for_file_name = false,
                    drag_and_drop = {
                        insert_mode = true,
                    },
                    -- required for Windows users
                    use_absolute_path = true,
                },
            },
        },

    },
    opts = {
        windows = {
            input = {
                prefix = "  "
            }
        },
        provider = "siliconflow",
        vendors = {
            siliconflow = {
                __inherited_from = 'openai',
                endpoint = 'https://api.siliconflow.cn/v1',
                api_key_name = 'cmd: rbw get siliconflow --field=key',
                model = 'deepseek-ai/DeepSeek-V3',
            },
            chutes = {
                __inherited_from = 'openai',
                endpoint = 'https://llm.chutes.ai/v1',
                api_key_name = 'cmd: rbw get chutes-api',
                model = 'deepseek-ai/DeepSeek-V3-0324',
            },
        }
    },

}
