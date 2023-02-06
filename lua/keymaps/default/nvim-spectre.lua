return {
    {
        mode = { "n", "i" },
        "<C-k>h",
        function()
            if vim.g.spectre_opend then
                require("spectre").close()
                vim.g.spectre_opend = false
            else
                require("spectre").open()
                vim.g.spectre_opend = true
            end
        end,
    },
}
