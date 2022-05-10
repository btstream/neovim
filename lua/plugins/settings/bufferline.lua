require("bufferline").setup({
    options = {
        numbers = "ordinal", -- "none" | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
        --- @deprecated, please specify numbers as a function to customize the styling
        -- number_style = "superscript" | "subscript" | "" | { "none", "subscript" }, -- buffer_id at index 1, ordinal at index 2
        close_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
        right_mouse_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
        left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
        middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
        -- NOTE: this plugin is designed with this icon in mind,
        -- and so changing this is NOT recommended, this is intended
        -- as an escape hatch for people who cannot bear it for whatever reason
        indicator_icon = "▎",
        buffer_close_icon = "",
        modified_icon = "●",
        close_icon = "",
        left_trunc_marker = "",
        right_trunc_marker = "",
        --- name_formatter can be used to change the buffer's label in the bufferline.
        --- Please note some names can/will break the
        --- bufferline so use this at your discretion knowing that it has
        --- some limitations that will *NOT* be fixed.
        name_formatter = function(buf) -- buf contains a "name", "path" and "bufnr"
            -- remove extension from markdown files for example
            if buf.name:match("%.md") then
                return vim.fn.fnamemodify(buf.name, ":t:r")
            end
        end,
        max_name_length = 18,
        max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
        tab_size = 18,
        diagnostics = "nvim_lsp", -- false | "nvim_lsp" | "coc",
        diagnostics_update_in_insert = false,
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
            return "(" .. count .. ")"
        end,
        -- NOTE: this will be called a lot so don't do any heavy processing here
        -- custom_filter = function(buf_number)
        --     -- filter out filetypes you don't want to see
        --     if vim.bo[buf_number].filetype ~= "<i-dont-want-to-see-this>" then
        --         return true
        --     end
        --     -- filter out by buffer name
        --     if vim.fn.bufname(buf_number) ~= "<buffer-name-I-dont-want>" then
        --         return true
        --     end
        --     -- filter out based on arbitrary rules
        --     -- e.g. filter out vim wiki buffer from tabline in your work repo
        --     if vim.fn.getcwd() == "<work-repo>" and vim.bo[buf_number].filetype ~= "wiki" then
        --         return true
        --     end
        -- end,
        -- offsets = {{filetype = "NvimTree", text = "File Explorer", text_align = "lefgcct" | "center" | "right"}},
        offsets = {
            {
                filetype = "NvimTree",
                text = function()
                    -- return vim.fn.getcwd()
                    return "File Explorer"
                end,
                highlight = "Directory",
                text_align = "center",
            },
            { filetype = "Outline", text = "Outline", highlight = "Directory", text_align = "center" },
        },
        show_buffer_icons = true, -- disable filetype icons for buffers
        show_buffer_close_icons = true,
        show_close_icon = true,
        show_tab_indicators = true,
        persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
        -- can also be a table containing 2 custom separators
        -- [focused and unfocused]. eg: { '|', '|' }
        separator_style = "thick", -- "slant" | "thick" | "thin" | { 'any', 'any' },
        enforce_regular_tabs = false,
        always_show_bufferline = true,
        sort_by = "id", -- 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs' | function(buffer_a, buffer_b)
        -- add custom logic
        -- return buffer_a.modified > buffer_b.modified
        -- end
    },
})

local map = vim.keymap.set

-- Move to previous/next
map("n", "<A-,>", "<cmd>BufferLineCyclePrev<CR>")
map("n", "<A-.>", "<cmd>BufferLineCycleNext<CR>")
-- Re-order to previous/next
-- map('n', '<A-<>', ':BufferMovePrevious<CR>')
-- map('n', '<A->>', ' :BufferMoveNext<CR>')
-- Goto buffer in position...
map("n", "<A-1>", "<cmd>BufferLineGoToBuffer 1<CR>")
map("n", "<A-2>", "<cmd>BufferLineGoToBuffer 2<CR>")
map("n", "<A-3>", "<cmd>BufferLineGoToBuffer 3<CR>")
map("n", "<A-4>", "<cmd>BufferLineGoToBuffer 4<CR>")
map("n", "<A-5>", "<cmd>BufferLineGoToBuffer 5<CR>")
map("n", "<A-6>", "<cmd>BufferLineGoToBuffer 6<CR>")
map("n", "<A-7>", "<cmd>BufferLineGoToBuffer 7<CR>")
map("n", "<A-8>", "<cmd>BufferLineGoToBuffer 8<CR>")
map("n", "<A-9>", "<cmd>BufferLineGoToBuffer 9<CR>")
-- map('n', '<A-0>', ':BufferLast<CR>')
-- Close buffer
map({ "n", "i" }, "<A-w>", "<cmd>bdelete!<CR>")
-- Wipeout buffer
--                 :BufferWipeout<CR>
-- Close commands
--                 :BufferCloseAllButCurrent<CR>
--                 :BufferCloseBuffersLeft<CR>
--                 :BufferCloseBuffersRight<CR>
-- Magic buffer-picking mode
map("n", "<Space>pp", "<cmd>BufferLinePick<CR>")
-- Sort automatically by...
-- map('n', '<Space>bb', ':BufferOrderByBufferNumber<CR>')
-- map('n', '<Space>bd', ':BufferOrderByDirectory<CR>')
-- map('n', '<Space>bl', ':BufferOrderByLanguage<CR>')
