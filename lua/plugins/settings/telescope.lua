local map = vim.keymap.set
local actions = require("telescope.actions")
require("telescope").setup({
    defaults = {
        sorting_strategy = "ascending",
        layout_config = { prompt_position = "top" },
        mappings = { i = { ["<esc>"] = actions.close }, n = { ["<esc>"] = actions.close } },
        prompt_prefix = "     ",
        selection_caret = "  ",
        entry_prefix = "  ",
    },
    pickers = {
        -- find_files = {
        --     theme = "dropdown"
        -- },
        lsp_code_actions = { theme = "cursor" },
    },
    extensions = {
        ["ui-select"] = { require("telescope.themes").get_dropdown() },
        fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
        },
    },
})

require("telescope").load_extension("ui-select")
require("telescope").load_extension("fzf")

-- find files
map("n", "<C-k>p", "<cmd>Telescope find_files<cr>")
map("i", "<C-k>p", "<Esc><cmd>Telescope find_files<cr>")

-- find symbols
map("n", "<C-k>s", "<cmd>Telescope lsp_document_symbols<cr>")
map("i", "<C-k>s", "<Esc><cmd>Telescope lsp_document_symbols<cr>")
map("n", "<C-k><S-s>", "<cmd>Telescope lsp_workspace_symbols<cr>")
map("i", "<C-k><S-s>", "<Esc><cmd>Telescope lsp_workspace_symbols<cr>")

-- global find
map("i", "<C-k>f", "<ESC><cmd>Telescope live_grep<cr>")
map("n", "<C-k>f", "<ESC><cmd>Telescope live_grep<cr>")

-- code actions
-- registers
map({ "n", "i" }, "<C-k>r", "<Esc><cmd>Telescope registers<cr>")
