return {
    "shortcuts/no-neck-pain.nvim",
    config = function()
        require("no-neck-pain").setup({
            width = 80,
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
