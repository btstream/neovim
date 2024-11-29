return {
    "Bekaboo/dropbar.nvim",
    event = "User BufReadRealFile",
    enabled = function()
        return vim.fn.has("nvim-0.10") == 1
    end,
    config = function(_, opts)
        -- need to add space for each symbols
        local symbols = {}
        for key, value in pairs(require("themes.icons").lsp_symbols) do
            symbols[key] = string.format("%s ", value)
        end
        require("dropbar").setup(vim.tbl_extend("keep", opts, {
            bar = {
                enable = function(buf, win)
                    return not vim.api.nvim_win_get_config(win).zindex
                        and vim.bo[buf].buftype == ""
                        and vim.api.nvim_buf_get_name(buf) ~= ""
                        and not vim.wo[win].diff
                        and vim.api.nvim_get_option_value("filetype", { buf = buf }) ~= "terminal"
                end,
            },
            icons = {
                kinds = {
                    symbols = symbols,
                },
            },
        }))
    end,
}
