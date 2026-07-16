local ft_ts_parser_map = setmetatable({
    jsonc = "json5",
    sshconfig = "ssh_config"
}, {
    __index = function(_, k)
        return k
    end
})


return {
    -- "nvim-treesitter/nvim-treesitter",
    "romus204/tree-sitter-manager.nvim",
    -- build = ":TSUpdate",
    -- event = "User BufReadRealFile",
    event = "BufReadPre",
    branch = "main",
    -- dependencies = { "mrjones2014/nvim-ts-rainbow" },
    dependencies = { "HiPhish/rainbow-delimiters.nvim" },
    module = false,
    config = function()
        local ts = require("tree-sitter-manager")
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
            "ssh_config"
        }
        ts.setup({
            ensure_installed = ensure_installed,
            highlight = false
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


        -- disable rainbow-delimiters' autocmd, as we need to enabled it manually
        -- to maed lazy load work
        vim.api.nvim_del_augroup_by_name("TSRainbowDelimits")

        -- auto cmd to enable nvim-treesitter
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "*",
            callback = vim.schedule_wrap(function(ev)
                local ts_parser = ft_ts_parser_map[ev.match]
                if vim.tbl_contains(ensure_installed, ts_parser) then
                    vim.treesitter.start(ev.buf, ts_parser)

                    -- set rainbow-delimiters, code from rainbow-delimiters
                    local config = require('rainbow-delimiters.config')
                    local lib    = require('rainbow-delimiters.lib')
                    local lang   = vim.treesitter.language.get_lang(ev.match)
                    local bufnr  = ev.buf
                    if not config.enabled_for(lang) then return end
                    if not config.enabled_when(bufnr) then return end
                    lib.attach(bufnr)
                end
            end)
        })
    end,
}
