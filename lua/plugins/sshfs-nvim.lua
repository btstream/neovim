local os_path = require("utils.os.path")
return {
    "uhs-robert/sshfs.nvim",
    opts = function()
        local ssh_configs = { -- Table of ssh config file locations to use
            "~/.ssh/config",
            "/etc/ssh/ssh_config",
        }

        local conf_d_path = vim.fn.expand("~/.ssh/conf.d")
        if os_path.exists(conf_d_path) then
            for _, c in pairs(os_path.ls(conf_d_path)) do
                ssh_configs[#ssh_configs + 1] = os_path.join(conf_d_path, c)
            end
        end

        return {
            -- Refer to the configuration section below
            -- or leave empty for defaults
            connections = {
                ssh_configs = ssh_configs, -- SSHFS mount options (table of key-value pairs converted to sshfs -o arguments)
                -- Boolean flags: set to true to include, false/nil to omit
                -- String/number values: converted to key=value format
                sshfs_options = {
                    reconnect = true,         -- Auto-reconnect on connection loss
                    ConnectTimeout = 5,       -- Connection timeout in seconds
                    compression = "yes",      -- Enable compression
                    ServerAliveInterval = 15, -- Keep-alive interval (15s × 3 = 45s timeout)
                    ServerAliveCountMax = 3,  -- Keep-alive message count
                    dir_cache = "yes",        -- Enable directory caching
                    dcache_timeout = 300,     -- Cache timeout in seconds
                    dcache_max_size = 10000,  -- Max cache size
                    -- allow_other = true,        -- Allow other users to access mount
                    -- uid = "1000,gid=1000",     -- Set file ownership (use string for complex values)
                    -- follow_symlinks = true,                       -- Follow symbolic links
                },
                control_persist = "10m",                          -- How long to keep ControlMaster connection alive after last use
                socket_dir = vim.fn.expand("$HOME/.ssh/sockets"), -- Directory for ControlMaster sockets
            },
            mounts = {
                base_dir = os_path.join(vim.fn.stdpath("data"), "sshfs", "mnt"), -- where remote mounts are created
            },
        }
    end,
}
