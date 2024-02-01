local nonfiletypes = require("utils.filetype_tools").get_nonfiletypes()
local function go_to_tab(index)
    return function()
        -- local state = require("bufferline.state")
        local config = require("bufferline.config")
        -- if config:is_tabline() and vim.api.nvim_tabpage_is_valid(id) then
        --     vim.api.nvim_set_current_tabpage(id)
        -- elseif vim.api.nvim_buf_is_valid(id) then
        --     vim.api.nvim_set_current_buf(id)
        -- end
        local list = require("bufferline.state").visible_components
        local element = list[index]
        if index == -1 or not element then
            element = list[#list]
        end

        if vim.tbl_contains(nonfiletypes, vim.api.nvim_get_option_value("filetype", { buf = 0 })) then
            local windows = vim.api.nvim_tabpage_list_wins(0)
            for _, w in pairs(windows) do
                local buf_in_w = vim.api.nvim_win_get_buf(w)

                -- find first normal window contains a normal file
                if
                    not vim.tbl_contains(nonfiletypes, vim.api.nvim_get_option_value("filetype", { buf = buf_in_w }))
                then
                    if element then
                        if config:is_tabline() and vim.api.nvim_tabpage_is_valid(element.id) then
                            vim.api.nvim_set_current_tabpage(element.id)
                        elseif vim.api.nvim_buf_is_valid(element.id) then
                            vim.api.nvim_win_set_buf(w, element.id)
                        end
                    end
                    return
                end
            end
        else
            vim.api.nvim_win_set_buf(0, element.id)
        end
    end
end

return {
    { "n", "<A-,>", "<cmd>BufferLineCyclePrev<CR>" },
    { "n", "<A-.>", "<cmd>BufferLineCycleNext<CR>" },
    -- { "n", "<A-1>", "<cmd>BufferLineGoToBuffer 1<CR>" },
    -- { "n", "<A-2>", "<cmd>BufferLineGoToBuffer 2<CR>" },
    -- { "n", "<A-3>", "<cmd>BufferLineGoToBuffer 3<CR>" },
    -- { "n", "<A-4>", "<cmd>BufferLineGoToBuffer 4<CR>" },
    -- { "n", "<A-5>", "<cmd>BufferLineGoToBuffer 5<CR>" },
    -- { "n", "<A-6>", "<cmd>BufferLineGoToBuffer 6<CR>" },
    -- { "n", "<A-7>", "<cmd>BufferLineGoToBuffer 7<CR>" },
    -- { "n", "<A-8>", "<cmd>BufferLineGoToBuffer 8<CR>" },
    -- { "n", "<A-9>", "<cmd>BufferLineGoToBuffer 9<CR>" },
    { "n", "<A-1>", go_to_tab(1) },
    { "n", "<A-2>", go_to_tab(2) },
    { "n", "<A-3>", go_to_tab(3) },
    { "n", "<A-4>", go_to_tab(4) },
    { "n", "<A-5>", go_to_tab(5) },
    { "n", "<A-6>", go_to_tab(6) },
    { "n", "<A-7>", go_to_tab(7) },
    { "n", "<A-8>", go_to_tab(8) },
    { "n", "<A-9>", go_to_tab(9) },
    { "n", "<Space>pp", "<cmd>BufferLinePick<CR>" },

    { { "n", "i" }, "<A-w>", "<cmd>bdelete!<CR><cmd>bprevious<cr>" },

    {
        mode = { "n", "i" },
        "<C-k>b",
        function()
            require("plugins.neo-tree.utils").toggle()
        end,
        desc = "open sidebar",
    },
}
