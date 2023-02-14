local M = {}

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

    if #listed_buffers > 1 and vim.tbl_contains(listed_buffers, target_buf) then
        local current_buf = vim.api.nvim_get_current_buf()

        -- if active buf, just move to another buffer, delete it
        if current_buf == target_buf then
            vim.cmd.bnext()
        end
        vim.cmd("bdelete! " .. target_buf)
        return true
    elseif #listed_buffers == 1 then
        vim.cmd.quitall()
    else
        vim.cmd.quit()
    end
end

-- function M.setup()
vim.opt.confirm = true
vim.cmd([[cnoreabbrev <silent> q lua require("base.quit-behave").quit()<cr>]])
-- end

return M
