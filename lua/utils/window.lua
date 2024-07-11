local filetype = require("utils.filetype")
local M = {}

function M.get_buf_attached_wins(buf)
    local attached_win = 0
    for _, w in pairs(vim.api.nvim_tabpage_list_wins(0)) do
        if vim.api.nvim_win_get_buf(w) == buf then
            attached_win = attached_win + 1
        end
    end
    return attached_win
end

function M.quit(buf)
    -- get all listed bufs
    local buffers = vim.api.nvim_list_bufs()
    local listed_buffers = {}
    for _, b in pairs(buffers) do
        if vim.fn.buflisted(b) == 1 then
            table.insert(listed_buffers, b)
        end
    end

    -- get current buf
    local target_buf = buf ~= nil and buf or vim.api.nvim_win_get_buf(0)

    -- not listed buf, quit directly
    if vim.fn.buflisted(target_buf) ~= 1 then
        vim.cmd.quit()
        return
    end

    -- if command line window, close directly
    if vim.fn.expand("%f") == "[Command Line]" then
        vim.cmd("")
        return
    end

    -- if more than one window is opened, close current window first
    local opend_window = 0
    local target_buf_attached_wins = 0
    for _, w in pairs(vim.api.nvim_tabpage_list_wins(0)) do
        local buf_in_w = vim.api.nvim_win_get_buf(w)
        if vim.fn.buflisted(buf_in_w) == 1 then
            opend_window = opend_window + 1
            if buf_in_w == target_buf then
                target_buf_attached_wins = target_buf_attached_wins + 1
            end
        end
    end
    -- print(opend_window)
    if opend_window > 1 then
        vim.cmd.quit()
        if target_buf_attached_wins == 1 then
            vim.cmd("bdelete! " .. target_buf)
        end
        return
    end

    if #listed_buffers > 1 and vim.tbl_contains(listed_buffers, target_buf) then
        local current_buf = vim.api.nvim_get_current_buf()

        -- if active buf, just move to another buffer, delete it
        if current_buf == target_buf then
            -- if target_buf attached to more than one window, such as in a split or
            -- vsplit window
            if M.get_buf_attached_wins(target_buf) > 1 then
                vim.cmd.close()
                return
            else
                vim.cmd.bnext()
            end
        end

        vim.cmd("bdelete! " .. target_buf)
        return true
    elseif #listed_buffers == 1 then
        if M.get_buf_attached_wins(listed_buffers[1]) > 1 then
            vim.cmd.close()
        else
            vim.cmd.quitall()
        end
    else
        vim.cmd.quit()
    end
end

function M.close_others()
    local current_buf = vim.api.nvim_get_current_buf()
    local current_win = vim.api.nvim_get_current_win()
    local wins = vim.api.nvim_tabpage_list_wins(0)
    for _, w in pairs(wins) do
        local buf_in_w = vim.api.nvim_win_get_buf(w)
        if vim.fn.buflisted(buf_in_w) and not filetype.is_nonefiletype(buf_in_w) then
            if buf_in_w ~= current_buf or w ~= current_win then
                vim.api.nvim_win_close(w, true)
            end
        end
    end
end

function M.get_first_normal_window()
    local wins = vim.api.nvim_tabpage_list_wins(0)
    for _, w in pairs(wins) do
        local config = vim.api.nvim_win_get_config(w)
        if not config.zindex then
            local buf = vim.api.nvim_win_get_buf(w)
            if vim.fn.buflisted(buf) == 1 and not filetype.is_nonefiletype(buf) then
                return w
            end
        end
    end
end

return M
