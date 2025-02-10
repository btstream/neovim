return {
    "olimorris/codecompanion.nvim",
    event = { "User BufReadRealFile" },
    cmd = "CodeCompanion",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    opts = {
        log_level = "DEBUG",
        strategies = {
            chat = {
                adapter = "deepseek",
            },
            inline = {
                adapter = "deepseek"
            }
        },
        adapters = {
            deepseek = function()
                return require("codecompanion.adapters").extend("deepseek", {
                    env = {
                        api_key = "cmd: rbw get DeepSeek-API"
                    },
                    schema = {
                        model = {
                            default = "deepseek-chat",
                        }
                    }
                })
            end
        }
    }
}
