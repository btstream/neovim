local is_nonefiletype = require("utils.filetype").is_nonefiletype

local SIDE_BAR_OPEN_CMD = {
    "Neotree source=filesystem",
    "Outline",
    "Neotree source=buffers",
    "Neotree source=git_status",
}

local M = {}
function M.switch_tabs()
    local function go_to_tab(index)
        return function()
            vim.cmd.stopinsert()

            local is_nft, ft = is_nonefiletype()
            -- if sidebar
            if ft == "Outline" or ft == "neo-tree" then
                if index > 4 then
                    return
                end
                vim.cmd(SIDE_BAR_OPEN_CMD[index])
                return
            end

            ----------------------------------------------------------------------
            --                             buffline                             --
            ----------------------------------------------------------------------
            local config = require("bufferline.config")
            local list = require("bufferline.state").visible_components
            local element = list[index]
            if index == -1 or not element then
                element = list[#list]
            end

            if ft ~= "grug-far" and is_nft then
                local windows = vim.api.nvim_tabpage_list_wins(0)
                for _, w in pairs(windows) do
                    -- find first normal window contains a normal file
                    if not require("utils.filetype").is_nonefiletype() then
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
        { mode = { "n", "i" }, "<A-,>",     "<esc><cmd>BufferLineCyclePrev<CR>" },
        { mode = { "n", "i" }, "<A-.>",     "<esc><cmd>BufferLineCycleNext<CR>" },
        { mode = { "n", "i" }, "<A-1>",     go_to_tab(1) },
        { mode = { "n", "i" }, "<A-2>",     go_to_tab(2) },
        { mode = { "n", "i" }, "<A-3>",     go_to_tab(3) },
        { mode = { "n", "i" }, "<A-4>",     go_to_tab(4) },
        { mode = { "n", "i" }, "<A-5>",     go_to_tab(5) },
        { mode = { "n", "i" }, "<A-6>",     go_to_tab(6) },
        { mode = { "n", "i" }, "<A-7>",     go_to_tab(7) },
        { mode = { "n", "i" }, "<A-8>",     go_to_tab(8) },
        { mode = { "n", "i" }, "<A-9>",     go_to_tab(9) },
        { mode = { "n", "i" }, "<Space>pp", "<esc><cmd>BufferLinePick<CR>" },
        { mode = { "n", "i" }, "<A-w>",     require("utils.window").quit },
    }
end

return M
