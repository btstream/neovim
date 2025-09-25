local is_nonefiletype = require("utils.filetype").is_nonefiletype
local find_root = require("utils.os.path").find_root

vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*",
    nested = true,
    callback = vim.schedule_wrap(function(ev)
        -- ignore if is not a regulare file
        local is_nft, ft = is_nonefiletype()
        if is_nft then
            return
        end

        -- custom pwd
        local pwd = find_root() or vim.fn.getcwd()
        local bufnr = ev.buf
        local cur_buf_path = string.gsub(vim.fn.expand("%:p"), "^%w+://", "")
        local same_path = false

        -- check if current file in a project, if so, set to
        -- project's path, else set cwd to file's location
        for p in vim.fs.parents(cur_buf_path) do
            if p == pwd then
                same_path = true
                break
            end
        end

        if not same_path then
            pwd = vim.fs.dirname(cur_buf_path)
        end

        -- get lsp config
        local clients = vim.lsp.get_clients({ bufnr = bufnr })
        if clients ~= nil and #clients ~= 0 then
            for _, client in ipairs(clients) do
                if client.config.root_dir then
                    pwd = client.config.root_dir
                    break
                end
            end
        end

        if pwd ~= vim.fn.getcwd() then
            vim.api.nvim_set_current_dir(pwd)
        end
    end)
})
