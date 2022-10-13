local symbols = {}
for k, v in pairs(require("themes.icons").lsp_symbol_icons) do
    symbols[k] = { icon = v }
end

require("symbols-outline").setup({
    highlight_hovered_item = true,
    show_guides = true,
    auto_preview = false,
    relative_width = false,
    position = "right",
    width = 40,
    show_numbers = false,
    show_relative_numbers = false,
    show_symbol_details = true,
    preview_bg_highlight = "NormalFloat",
    keymaps = { -- These keymaps can be a string or a table for multiple keys
        close = { "<Esc>", "q" },
        goto_location = "<Cr>",
        focus_location = "o",
        hover_symbol = "<C-space>",
        toggle_preview = "K",
        rename_symbol = "r",
        code_actions = "a",
    },
    lsp_blacklist = {},
    symbol_blacklist = {},
    symbols = symbols,
})

local map = vim.keymap.set
map("n", "<C-k>o", "<cmd>SymbolsOutline<cr>")
