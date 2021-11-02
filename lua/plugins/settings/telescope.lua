local map = vim.api.nvim_set_keymap
local actions = require("telescope.actions")
require('telescope').setup{
    defaults = {
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
        find_files = {
            theme = "dropdown"
        },
        lsp_code_actions = {
            theme = "cursor"
        }
    },
    extensions = {}
}

local mopts = {noremap = true, silent = true}

map('n', '<C-k>p', '<cmd>Telescope find_files<cr>', mopts)
map('i', '<C-k>p', '<Esc><cmd>Telescope find_files<cr>', mopts)
map('n', '<C-k>s', '<cmd>Telescope lsp_document_symbols<cr>', mopts)
map('i', '<C-k>s', '<Esc><cmd>Telescope lsp_document_symbols<cr>', mopts)
map('n', '<C-k><S-s>', '<cmd>Telescope lsp_workspace_symbols<cr>', mopts)
map('i', '<C-k><S-s>', '<Esc><cmd>Telescope lsp_workspace_symbols<cr>', mopts)
map('n', '<C-k>.', '<cmd>Telescope lsp_code_actions<cr>', mopts)
map('i', '<C-k>.', '<Esc><cmd>Telescope lsp_code_actions<cr>', mopts)

