return {
    "folke/sidekick.nvim",
    opts = {
        -- nes = {
        --     enabled = true
        -- },
        -- add any options here
        cli = {
            mux = {
                backend = "zellij",
                enabled = true,
            },
            prompts = {
                Writing = "{file} 采用学术化的表述优化{this}之后的这一段文字的英语表述",
                Translate = "{file} 将{this}之后的这一段文字翻译成英语，要采用正式的学术风格",
                custom = function(ctx)
                    return "当前文件: " .. ctx.buf .. " 当前行 " .. ctx.row
                end,
            },

        },
    },

    keys = {
        {
            "<C-g>",
            function()
                -- if there is a next edit, jump to it, otherwise apply it if any
                if require("sidekick").nes_jump_or_apply() then
                    return -- jumped or applied
                end

                -- if you are using Neovim's native inline completions
                if vim.lsp.inline_completion.get() then
                    return
                end

                -- any other things (like snippets) you want to do on <tab> go here.

                -- fall back to normal tab
                return "<C-g>"
            end,
            mode = { "i", "n" },
            expr = true,
            desc = "Goto/Apply Next Edit Suggestion",
        },
        {
            "<c-k>a",
            function() require("sidekick.cli").toggle("opencode") end,
            desc = "Sidekick Toggle",
            mode = { "n", "t", "i", "x" },
        },
        {
            "<leader>aa",
            function() require("sidekick.cli").toggle() end,
            desc = "Sidekick Toggle CLI",
        },
        {
            "<leader>as",
            function() require("sidekick.cli").select() end,
            -- Or to select only installed tools:
            -- require("sidekick.cli").select({ filter = { installed = true } })
            desc = "Select CLI",
        },
        {
            "<leader>ad",
            function() require("sidekick.cli").close() end,
            desc = "Detach a CLI Session",
        },
        {
            "<leader>at",
            function() require("sidekick.cli").send({ msg = "{this}" }) end,
            mode = { "x", "n" },
            desc = "Send This",
        },
        {
            "<leader>af",
            function() require("sidekick.cli").send({ msg = "{file}" }) end,
            desc = "Send File",
        },
        {
            "<leader>av",
            function() require("sidekick.cli").send({ msg = "{selection}" }) end,
            mode = { "x" },
            desc = "Send Visual Selection",
        },
        {
            "<C-k>ap",
            function() require("sidekick.cli").prompt() end,
            mode = { "n", "i", "x" },
            desc = "Sidekick Select Prompt",
        },
    },
    cmd = { "Sidekick" },
}
