local is_nonefiletype = require("utils.filetype").is_nonefiletype
local find_root = require("utils.os.path").find_root
local os = require("utils.os").name()

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

        -- if file is under XDG_CONFIG_HOME/~/.config on Linux, set cwd to that subdir
        if os == "linux" or os == "macos" then
            local config_homes = {
                vim.env.XDG_CONFIG_HOME or vim.fn.expand("~/.config"),
                vim.fn.expand("~/.local/share/"),
                vim.fn.expand("~/.local/state/")
            }
            local norm_buf_path = vim.fs.normalize(cur_buf_path)
            for _, config_home in ipairs(config_homes) do
                config_home = vim.fs.normalize(config_home)
                if norm_buf_path == config_home or vim.startswith(norm_buf_path, config_home .. "/") then
                    local rel = norm_buf_path:sub(#config_home + 2)
                    local first = rel:match("([^/]+)")
                    if first == nil or first == "" or not rel:find("/") then
                        pwd = config_home
                    else
                        pwd = config_home .. "/" .. first
                    end
                    break
                end
            end
        end

        if pwd ~= vim.fn.getcwd() then
            vim.api.nvim_set_current_dir(pwd)
        end
    end)
})
