local go_to = function(index)
    return function()
        require("plugins.neo-tree.utils").goto_source(index)
    end
end

return {
    { "n", "<A-1>", go_to(1) },
    { "n", "<A-2>", go_to(2) },
    { "n", "<A-3>", go_to(3) },
    { "n", "<A-4>", go_to(4) },
    { "n", "<A-5>", go_to(5) },
    { "n", "<A-6>", go_to(6) },
    { "n", "<A-7>", go_to(7) },
    { "n", "<A-8>", go_to(8) },
    { "n", "<A-9>", go_to(9) },
    { "n", "<A-,>", '<cmd>lua require("plugins.neo-tree.utils").goto_previous_source()<CR>' },
    { "n", "<A-.>", '<cmd>lua require("plugins.neo-tree.utils").goto_next_source()<CR>' },

    {
        mode = { "n", "i" },
        "<C-k>b",
        function()
            require("plugins.neo-tree.utils").toggle()
        end,
        desc = "open sidebar",
    },
}
