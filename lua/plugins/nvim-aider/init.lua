return {
    "GeorgesAlkhouri/nvim-aider",
    cmd = "Aider",
    enabled = vim.fn.executable("aider") == 1,
    keys = {
        { "<leader>a/", "<cmd>Aider toggle<cr>",       desc = "Toggle Aider" },
        { "<leader>as", "<cmd>Aider send<cr>",         desc = "Send to Aider",                  mode = { "n", "v" } },
        { "<leader>ac", "<cmd>Aider command<cr>",      desc = "Aider Commands" },
        { "<leader>ab", "<cmd>Aider buffer<cr>",       desc = "Send Buffer" },
        { "<leader>a+", "<cmd>Aider add<cr>",          desc = "Add File" },
        { "<leader>a-", "<cmd>Aider drop<cr>",         desc = "Drop File" },
        { "<leader>ar", "<cmd>Aider add readonly<cr>", desc = "Add Read-Only" },
        { "<leader>aR", "<cmd>Aider reset<cr>",        desc = "Reset Session" },
        -- Example nvim-tree.lua integration if needed
        { "<leader>a+", "<cmd>AiderTreeAddFile<cr>",   desc = "Add File from Tree to Aider",    ft = "NvimTree" },
        { "<leader>a-", "<cmd>AiderTreeDropFile<cr>",  desc = "Drop File from Tree from Aider", ft = "NvimTree" },
    },
    dependencies = {
        "folke/snacks.nvim",
        --- Neo-tree integration
        {
            "nvim-neo-tree/neo-tree.nvim",
            opts = function(_, opts)
                require("nvim_aider.neo_tree").setup(opts)
            end,
        },
    },
    config = function()
        -- this is a custom hack, to dynamicly config parameter of aiders
        require("plugins.nvim-aider.options_generator")
        Snacks.config.style("aider", {
            bo = {
                filetype = "aider"
            }
        })
        require("nvim_aider").setup({
            -- Command that executes Aider
            aider_cmd = "aider",
            -- Automatically reload buffers changed by Aider (requires vim.o.autoread = true)
            auto_reload = true,
            -- snacks.picker.layout.Config configuration
            picker_cfg = {
                preset = "vscode",
            },
            -- Other snacks.terminal.Opts options
            config = {
                os = { editPreset = "nvim-remote" },
                gui = { nerdFontsVersion = "3" },
            },
            win = {
                wo = {
                    winbar = "",
                    winhighlight = "NormalFloat:Normal",
                    -- statuscolumn = "  ",
                },
                style = "aider",
                position = "right",
            },
        })
    end,
}
