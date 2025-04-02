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
        opts = {
            language = "Chinese",
        },
        strategies = {
            chat = {
                adapter = "openrouter_deepseek",
            },
            inline = {
                adapter = "openrouter_deepseek"
            }
        },
        display = {
            chat = {
                window = {
                    width = 0.35,
                    opts = {
                        breakindent = true,
                        cursorcolumn = false,
                        cursorline = false,
                        foldcolumn = "0",
                        linebreak = true,
                        list = false,
                        number = false,
                        numberwidth = 1,
                        signcolumn = "no",
                        spell = false,
                        wrap = true,
                    }
                }
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
            end,
            openrouter_deepseek = function()
                return require("codecompanion.adapters").extend("openai_compatible", {
                    env = {
                        url = "https://openrouter.ai/api",
                        api_key = "cmd: rbw get openrouter-ai-apikey",
                        chat_url = "/v1/chat/completions",
                    },
                    schema = {
                        model = {
                            default = "deepseek/deepseek-r1:free",
                        },
                    },
                })
            end
        }
    }
}
