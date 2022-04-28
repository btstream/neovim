local M = {}

local gl = require("galaxyline")
local gls = gl.section
local lsp_status = require("lsp-status")
local buffer = require("galaxyline.providers.buffer")
local condition = require("galaxyline.condition")
local fileinfo = require("galaxyline.providers.fileinfo")
local lsp = require("galaxyline.providers.lsp")
local vcs = require("galaxyline.providers.vcs")
lsp_status.config({})

M.setup = function()
    -- require("plugins.settings.statusline.themes.colors").init_or_update()
    local colors = require("plugins.settings.statusline.themes.colors")
    local icons = require("plugins.settings.statusline.themes.icons")
    colors.init_or_update(nil)

    gl.short_line_list = {
        "NvimTree",
        "help",
        "tagbar",
        "toggleterm",
        "Outline",
        "packer",
        "dapui_watches",
        "dapui_stacks",
        "dapui_config",
        "dapui_breakpoints",
        "dapui_scopes",
        "dap-repl",
    }

    --------------------
    -- left
    --------------------
    gls.left[0] = {
        ModeNum = {
            highlight = { colors.bg, colors.get_mode_color() },
            provider = function()
                colors.set_indicator_color("ModeNum")
                -- return '  ' .. icons.get_mode_icon() .. num_icons.get() .. ' '
                return "  " .. icons.get_mode_icon() .. " "
            end,
        },
    }

    gls.left[1] = {
        LFileSepL = {
            highlight = { colors.get_mode_color(), colors.bg },
            provider = function()
                colors.set_indicator_color("LFileSepL", true)
                return " "
                -- return ''
            end,
        },
    }

    gls.left[2] = {
        FileIcon = {
            highlight = { fileinfo.get_file_icon_color(), colors.bg },
            provider = function()
                return "  " .. fileinfo.get_file_icon()
            end,
        },
    }

    gls.left[3] = {
        FileName = {
            highlight = { colors.fg, colors.bg },
            provider = function()
                local file_name = fileinfo.get_current_file_name()
                if file_name == nil or file_name:len() == 0 then
                    -- if buffer_type ~= nil or buffer_type:len() ~= 0 then
                    --     return buffer_type:upper() .. ' '
                    -- end
                    -- return 'EMPTY '
                    return buffer.get_buffer_filetype()
                end
                -- colors.set_indicator_color('FileInfo', true)
                return file_name
            end,
        },
    }

    gls.left[4] = {
        LFileSepR = {
            highlight = { colors.get_mode_color(), colors.bg },
            provider = function()
                colors.set_indicator_color("LFileSepR", true)
                -- return ''
                return ""
            end,
        },
    }

    gls.left[5] = {
        GitIcon = {
            condition = condition.check_git_workspace,
            highlight = { colors.orange, colors.bg },
            provider = function()
                return "  "
            end,
        },
    }

    -- git branch
    gls.left[6] = {
        GitBranch = {
            condition = condition.check_git_workspace,
            highlight = { colors.fg, colors.bg },

            provider = function()
                local branch = vcs.get_git_branch()
                if branch == nil then
                    branch = "???"
                end
                return "  " .. branch .. " "
            end,
        },
    }

    -- git add
    gls.left[7] = {
        DiffAdd = {
            highlight = { colors.green, colors.bg },
            provider = function()
                local r = vcs.diff_add()
                if r then
                    return " " .. r
                end
            end,
        },
    }

    -- git remove
    gls.left[8] = {
        DiffModified = {
            condition = function()
                return vcs.diff_modified() ~= nil
            end,
            highlight = { colors.blue, colors.bg },
            provider = function()
                local r = vcs.diff_modified()
                if r then
                    return " " .. r
                end
            end,
        },
    }

    -- git remove
    gls.left[9] = {
        DiffRemoved = {
            highlight = { colors.red, colors.bg },
            provider = function()
                local r = vcs.diff_remove()
                if r then
                    return " " .. r
                end
            end,
        },
    }

    --------------------
    -- mid
    --------------------
    gls.mid[0] = {
        Empty = {
            hilight = { nil, nil },
            provider = function()
                return ""
            end,
        },
    }
    --------------------
    -- right
    --------------------
    gls.right[0] = {
        LspClient = { -- {{{2
            highlight = { colors.fg, colors.bg },
            provider = function()
                local icon = "   "
                local active_lsp = lsp.get_lsp_client()
                if active_lsp == "No Active Lsp" then
                    return ""
                end

                local progress = lsp_status.status_progress() .. " "
                if string.len(progress) > 1 then
                    return icon .. "" .. progress
                else
                    return icon .. active_lsp .. " "
                end
            end,
        },
    }

    gls.right[1] = {
        DiagnosticError = {
            highlight = { colors.red, colors.bg },
            provider = function()
                local icon = " "
                local errors = vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
                local count = #errors
                if count == 0 then
                    return ""
                end
                return icon .. count .. " "
            end,
        },
    }

    gls.right[2] = {
        DiagnosticWarn = {
            highlight = { colors.yellow, colors.bg },
            provider = function()
                local icon = " "
                local warnings = vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
                local count = #warnings
                if count == 0 then
                    return ""
                end
                return icon .. count .. " "
            end,
        },
    }

    gls.right[3] = {
        DiagnosticHint = {
            highlight = { colors.cyan, colors.bg },
            provider = function()
                local icon = " "
                local hints = vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
                local count = #hints
                if count == 0 then
                    return ""
                end
                return icon .. count .. " "
            end,
        },
    }

    gls.right[4] = {
        RFileSepL = {
            highlight = { colors.get_mode_color(), colors.bg },
            provider = function()
                colors.set_indicator_color("RFileSepL", true)
                return "  "
            end,
        },
    }

    gls.right[5] = {
        FileInfo = {
            highlight = { colors.fg, colors.bg },
            provider = function()
                local format_icon = { ["DOS"] = " ", ["MAC"] = " ", ["UNIX"] = " " }
                local encode = fileinfo.get_file_encode()
                local format = fileinfo.get_file_format()
                colors.set_indicator_color("FileInfo", true)
                return " " .. encode .. " " .. format_icon[format]
            end,
        },
    }

    gls.right[6] = {
        RFileSepR = {
            highlight = { colors.get_mode_color(), colors.bg },
            provider = function()
                colors.set_indicator_color("RFileSepR", true)
                -- return ''
                return " "
            end,
        },
    }

    gls.right[7] = {
        LineInfo = {
            highlight = { colors.bg, colors.get_mode_color() },
            provider = function()
                colors.set_indicator_color("LineInfo")
                local cursor = vim.api.nvim_win_get_cursor(0)
                return "   " .. cursor[1] .. "/" .. vim.api.nvim_buf_line_count(0) .. ":" .. cursor[2] .. " "
            end,
        },
    }

    -- local icons = require("plugins.settings.statusline.themes.icons")
    gls.short_line_left[0] = {
        FiletypeIcon = {
            highlight = { colors.bg, colors.get_mode_color() },
            provider = function()
                -- colors.set_indicator_color('FiletypeIcon')
                colors.set_filetype_color("FiletypeIcon")
                return "  " .. icons.get_filetype_icon()
            end,
        },
    }
    gls.short_line_left[1] = {
        LFileSepLShort = {
            highlight = { colors.get_mode_color(), colors.bg },
            provider = function()
                colors.set_filetype_color("LFileSepLShort", false)
                -- return ''
                return ""
            end,
        },
    }

    -- gls.short_line_left[2] = gls.left[2]
    gls.short_line_left[2] = {
        Space = {
            highlight = { colors.bg, colors.bg },
            provider = function()
                return " "
            end,
        },
    }
    gls.short_line_left[3] = gls.left[3]
    -- gls.short_line_right[0] = gls.right[6]
    gls.short_line_right[0] = {
        RFileSepRShort = {
            highlight = { colors.get_mode_color(), colors.bg },
            provider = function()
                colors.set_filetype_color("RFileSepRShort", false)
                -- return ''
                return ""
            end,
        },
    }

    -- for mid background
    vim.cmd([[hi! StatusLine guibg=]] .. colors.bg)
    vim.cmd([[
    autocmd ColorScheme * lua require('plugins.settings.statusline').update_status_bg()
    ]])
end

M.update_status_bg = function()
    require("plugins.settings.statusline.themes.colors").init_or_update(nil)
    vim.cmd([[hi! StatusLine guibg=]] .. require("plugins.settings.statusline.themes.colors").bg)
end

return M
