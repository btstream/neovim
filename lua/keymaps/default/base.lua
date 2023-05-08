----------------------------------------------------------------------
--                       Config basic key map                       --
----------------------------------------------------------------------

-- local map = require("utils.keymap_tools").map
local m = { "i", "n", "v" }

return {
    {
        { "n", "i" },
        "<C-s>",
        function()
            if not vim.api.nvim_buf_get_option(0, "modifiable") then
                -- vim.notify("Buf is not modifiable", vim.log.levels.INFO)
                return
            end

            -- if vim.api.nvim_buf_get_option(vim.api.nvim_get_current_buf(), "readonly") then
            --     vim.cmd("SudaWrite")
            -- else
            vim.cmd("write")
            vim.cmd("stopinsert")
            -- end
        end,
    },
    { "n", "<SPACEE>", "<Nop>" },
    { "i", "<S-Tab>", "<C-d>" },
    { "n", "<SPACEE>", "<Nop>" },

    { m, "<C-n>", "<down>" },
    { m, "<C-p>", "<up>" },
    { m, "<C-f>", "<right>" },
    { m, "<C-b>", "<left>" },
    { m, "<C-a>", "<home>" },
    { m, "<C-e>", "<end>" },

    -- clean search hilight
    -- map("n", "<Esc><Esc>", "<cmd>nohl<cr>")

    -- resize window
    { "n", "<C-S-right>", "<cmd>vertical resize +1<cr>" },
    { "n", "<C-S-left>", "<cmd>vertical resize -1<cr>" },
    { "n", "<C-S-up>", "<cmd>resize +1<cr>" },
    { "n", "<C-S-down>", "<cmd>resize -1<cr>" },

    -- move lines
    { "n", "<A-j>", "<cmd>m .+1<CR>==", { silent = true } },
    { "n", "<A-k>", "<cmd>m .-2<CR>==", { silent = true } },
    { "n", "<C-down>", "<cmd>m .+1<CR>==", { silent = true } },
    { "n", "<C-up>", "<cmd>m .-2<CR>==", { silent = true } },

    { "i", "<A-j>", "<Esc><cmd>m .+1<CR>==gi", { silent = true } },
    { "i", "<A-k>", "<Esc><cmd>m .-2<CR>==gi", { silent = true } },
    { "i", "<C-down>", "<Esc><cmd>m .+1<CR>==gi", { silent = true } },
    { "i", "<C-up>", "<Esc><cmd>m .-2<CR>==gi", { silent = true } },

    { "v", "<A-j>", "<cmd>m '>+1<CR>gv=gv", { silent = true } },
    { "v", "<A-k>", "<cmd>m '<-2<CR>gv=gv", { silent = true } },
    { "v", "<C-down>", "<cmd>m '>+1<CR>gv=gv", { silent = true } },
    { "v", "<C-up>", "<cmd>m '<-2<CR>gv=gv", { silent = true } },
}
