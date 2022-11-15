-- local map = vim.api.nvim_set_keymap
-- local map = vim.keymap.set
local signs = require("plugins.settings.lsp.ui").signs
local view = require("nvim-tree.view")

----------------------------------------------------------------------
--              prevent open buffer on NvimTree window              --
----------------------------------------------------------------------
local _abandon_current_window = view.abandon_current_window
view.abandon_current_window = function()
    view._prevent_buffer_override()
    _abandon_current_window()
end

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
    diagnostics = {
        enable = false,
        icons = { hint = signs.Hint, info = signs.Info, warning = signs.Warn, error = signs.Error },
    },
    update_focused_file = { enable = true, update_cwd = true, ignore_list = {} },
    system_open = { cmd = nil, args = {} },
    filters = { dotfiles = false, custom = {} },
    renderer = {
        indent_markers = {
            enable = false,
            icons = {
                corner = "└ ",
                edge = "│ ",
                none = "  ",
            },
        },
        icons = {
            glyphs = {
                git = {
                    unstaged = "",
                    staged = "",
                    unmerged = "",
                    renamed = "➜",
                    untracked = "",
                    deleted = "",
                    ignored = "◌",
                },
            },
        },
    },
    view = {
        width = 30,
        -- height = 30,
        hide_root_folder = false,
        side = "left",
        -- auto_resize = true,
        mappings = { custom_only = false, list = { { key = "<C-k>", action = "" } } },
    },
    actions = {
        open_file = {
            quit_on_open = false,
        },
    },
})

vim.api.nvim_create_autocmd({ "WinEnter", "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
    callback = function()
        if vim.bo.filetype == "NvimTree" then
            vim.cmd("stopinsert")
        end
    end,
})

-- map({ "n", "i" }, "<C-k>b", "<cmd>NvimTreeToggle<CR>")
-- map("i", "<C-k>b", "<Esc><cmd>NvimTreeToggle<CR>")

-- vim.cmd([[
-- augroup nvim-tree-refresh
--     au!
--     autocmd BufReadPost * NvimTreeRefresh
--     autocmd BufEnter * NvimTreeRefresh
-- augroup end
-- ]])
