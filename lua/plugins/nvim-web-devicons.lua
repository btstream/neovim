return {
    "nvim-tree/nvim-web-devicons",
    -- Load at startup so the remap and its ColorScheme hook exist before any
    -- consumer (bufferline, neo-tree, heirline) asks for icon colors.
    lazy = false,
    config = function()
        require("themes.devicons").apply()

        -- The palette handler in themes/autocmds.lua is registered earlier
        -- and refreshes the cached colors first; remap from the new palette.
        vim.api.nvim_create_autocmd("ColorScheme", {
            group = vim.api.nvim_create_augroup("ThemeDevicons", { clear = true }),
            callback = function()
                require("themes.devicons").apply()
            end,
        })
    end,
}
