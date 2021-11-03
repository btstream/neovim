local map = vim.api.nvim_set_keymap
local actions = require("telescope.actions")
require('telescope').setup{
    defaults = {
        sorting_strategy = "ascending",
        layout_config = {
            prompt_position = 'top'
        },
        mappings = {
            i = {
                 ["<esc>"] = actions.close
            },
            n = {
                 ["<esc>"] = actions.close
            }
        }
    },
    pickers = {
        -- find_files = {
        --     theme = "dropdown"
        -- },
        lsp_code_actions = {
            theme = "cursor"
        }
    },
    extensions = {}
}

local mopts = {noremap = true, silent = true}

-- find files
map('n', '<C-k>p', '<cmd>Telescope find_files<cr>', mopts)
map('i', '<C-k>p', '<Esc><cmd>Telescope find_files<cr>', mopts)

--find symbols
map('n', '<C-k>s', '<cmd>Telescope lsp_document_symbols<cr>', mopts)
map('i', '<C-k>s', '<Esc><cmd>Telescope lsp_document_symbols<cr>', mopts)
map('n', '<C-k><S-s>', '<cmd>Telescope lsp_workspace_symbols<cr>', mopts)
map('i', '<C-k><S-s>', '<Esc><cmd>Telescope lsp_workspace_symbols<cr>', mopts)

--global find
map('i', '<C-k>f', '<ESC><cmd>Telescope live_grep<cr>', mopts)
map('n', '<C-k>f', '<ESC><cmd>Telescope live_grep<cr>', mopts)

-- code actions
map('n', '<C-k>.', '<cmd>Telescope lsp_code_actions<cr>', mopts)
map('i', '<C-k>.', '<Esc><cmd>Telescope lsp_code_actions<cr>', mopts)

-- registers
map('i', '<C-p>', '<Esc><cmd>Telescope registers<cr>', mopts)
