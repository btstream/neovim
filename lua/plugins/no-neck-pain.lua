return {
    "shortcuts/no-neck-pain.nvim",
    keys = { {
        mode = { "n", "i" }, "<C-k>z", "<cmd>NoNeckPain<cr>", desc = "Open Zen Mode"
    } },
    config = function()
        require("no-neck-pain").setup({
            width = 60,
            buffers = {
                left = {
                    enabled = false,
                },
            },
            integrations = {
                sidekick_terminal = {
                    position = "right"
                }
            }
        })
    end
}
