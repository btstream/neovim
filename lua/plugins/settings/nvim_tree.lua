-- local map = vim.api.nvim_set_keymap
local map = vim.keymap.set

vim.g.nvim_tree_icons = { git = { unstaged = "", staged = "", untracked = "" } }

require("nvim-tree").setup({
    disable_netrw = true,
    hijack_netrw = true,
    open_on_setup = false,
    ignore_ft_on_setup = {},
    -- auto_close = false,
    open_on_tab = true,
    hijack_cursor = false,
    update_cwd = true,
    -- update_to_buf_dir = { enable = true, auto_open = true },
    diagnostics = { enable = false, icons = { hint = "", info = "", warning = "", error = "" } },
    update_focused_file = { enable = true, update_cwd = true, ignore_list = {} },
    system_open = { cmd = nil, args = {} },
    filters = { dotfiles = false, custom = {} },
    renderer = {
        indent_markers = {
            enable = true,
            icons = {
                corner = "└ ",
                edge = "│ ",
                none = "  ",
            },
        },
    },
    view = {
        width = 30,
        height = 30,
        hide_root_folder = false,
        side = "left",
        -- auto_resize = true,
        mappings = { custom_only = false, list = { { key = "<C-k>", action = "" } } },
    },
    actions = {
        open_file = {
            quit_on_open = true,
        },
    },
})
map("n", "<C-k>b", "<cmd>NvimTreeToggle<CR>")
map("i", "<C-k>b", "<Esc><cmd>NvimTreeToggle<CR>")

vim.cmd([[
augroup nvim-tree-refresh
    au!
    autocmd BufReadPost * NvimTreeRefresh
    autocmd BufEnter * NvimTreeRefresh
augroup end
]])
