return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    -- event = "User BufReadRealFile",
    event = "BufReadPre",
    branch = "main",
    -- dependencies = { "mrjones2014/nvim-ts-rainbow" },
    dependencies = { "HiPhish/rainbow-delimiters.nvim" },
    module = false,
    config = function()
        local ts = require("nvim-treesitter")
        local ensure_installed = {
            "bash",
            "c",
            "cpp",
            "comment",
            "diff",
            "html",
            "java",
            "javascript",
            "jsdoc",
            "json",
            "json5",
            "lua",
            "luadoc",
            "luap",
            "markdown",
            "markdown_inline",
            "python",
            "query",
            "regex",
            "rust",
            "toml",
            "tsx",
            "typescript",
            "vim",
            "vimdoc",
            "xml",
            "yaml",
        }
        ts.setup()

        -- ensure all parsers are installed
        local installed = ts.get_installed()
        local need_install = {}
        for _, v in pairs(ensure_installed) do
            if not vim.tbl_contains(installed, v) then
                need_install[#need_install + 1] = v
            end
        end
        if #need_install > 0 then
            ts.install(need_install)
        end

        -- auto cmd to enable nvim-treesitter
        vim.api.nvim_create_autocmd("FileType", {
            callback = vim.schedule_wrap(function(ev)
                local ft = ev.match
                if vim.tbl_contains(ensure_installed, ft) or ft == "jsonc" then
                    -- using jsonc for filetype and set syntax to json5
                    ft = ft == "jsonc" and "json5" or ft
                    vim.treesitter.start(0, ft)
                end
            end)
        })

        -- rainbow-delimiters
        local rainbow_delimiters = require("rainbow-delimiters")
        require("rainbow-delimiters.setup").setup({
            strategy = {
                [""] = rainbow_delimiters.strategy["global"],
                commonlisp = rainbow_delimiters.strategy["local"],
            },
            query = {
                [""] = "rainbow-delimiters",
                latex = "rainbow-blocks",
            },
            highlight = {
                "RainbowDelimiterYellow",
                "RainbowDelimiterGreen",
                "RainbowDelimiterBlue",
                "RainbowDelimiterOrange",
                "RainbowDelimiterViolet",
                "RainbowDelimiterCyan",
                "RainbowDelimiterRed",
            },
            blacklist = { "c", "cpp" },
        })
    end,
}
