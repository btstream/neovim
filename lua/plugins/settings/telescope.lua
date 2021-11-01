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

map('n', '<C-p>', '<cmd>Telescope find_files<cr>', {noremap = true, silent = true})
map('i', '<C-p>', '<Esc><cmd>Telescope find_files<cr>', {noremap = true, silent = true})
map('n', '<C-o>', '<cmd>Telescope lsp_document_symbols<cr>', {noremap = true, silent = true})
map('i', '<C-o>', '<Esc><cmd>Telescope lsp_document_symbols<cr>', {noremap = true, silent = true})
map('n', '<C-S-o>', '<cmd>Telescope lsp_workspace_symbols<cr>', {noremap = true, silent = true})
map('i', '<C-S-o>', '<Esc><cmd>Telescope lsp_workspace_symbols<cr>', {noremap = true, silent = true})
map('n', '<C-.>', '<cmd>Telescope lsp_code_actions<cr>', {noremap = true, silent = true})

