local is_nonefiletype = require("utils.filetype").is_nonefiletype
local find_root = require("utils.os.path").find_root

vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*",
    nested = true,
    callback = vim.schedule_wrap(function(ev)
        -- custom pwd
        local pwd = find_root()

        local bufnr = ev.buf

        -- ignore if is not a regulare file
        local is_nft, ft = is_nonefiletype()
        if is_nft then
            return
        end

        local clients = vim.lsp.get_clients({ bufnr = bufnr })
        if clients ~= nil and #clients ~= 0 then
            for _, client in ipairs(clients) do
                if client.config.root_dir then
                    pwd = client.config.root_dir
                    break
                end
            end
        end

        vim.api.nvim_set_current_dir(pwd)
    end)
})
