local M = {}

function M.quit()
    -- get all listed bufs
    local buffers = vim.api.nvim_list_bufs()
    local listed_buffers = {}
    for _, b in pairs(buffers) do
        if vim.fn.buflisted(b) == 1 then
            table.insert(listed_buffers, b)
        end
    end

    -- get current buf
    local current_buf = vim.api.nvim_win_get_buf(0)

    if vim.fn.buflisted(current_buf) ~= 1 then
        vim.cmd.quit()
        return
    end

    if #listed_buffers > 1 and vim.tbl_contains(listed_buffers, current_buf) then
        vim.cmd.bnext()
        vim.cmd.bdelete(current_buf)
    elseif #listed_buffers == 1 then
        vim.cmd.quitall()
    else
        vim.cmd.quit()
    end
end

-- function M.setup()
vim.opt.confirm = true
vim.cmd([[cnoreabbrev q lua require("base.quit-behave").quit()<cr><cmd>echon ''<cr>]])
-- end

return M
