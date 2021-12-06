local M = {}

local gl = require('galaxyline')
local gls = gl.section
local lsp_status = require('lsp-status')

lsp_status.config({})

-- functions to remap base16-themes to colors
local function get_colors(name)
    local bm = {
        bg = 'base01',
        fg = 'base04',
        red = 'base08',
        orange = 'base09',
        yellow = 'base0A',
        green = 'base0B',
        blue = 'base0D',
        cyan = 'base0C',
        purple = 'base0E',
        magenta = 'base0E',
        white = 'base05'
    }
    local _, b = vim.g.colors_name:find('base16')
    if b then
        return function()
            local colors = require('base16-colorscheme').colorschemes[vim.g.colors_name:sub(b + 2)]
            return colors[bm[name]]
        end
    else
        return require('galaxyline.themes.colors').get_color(name)
    end
end

M.setup = function()
    local colors = {
        bg = get_colors('bg'),
        fg = get_colors('fg'),
        red = get_colors('red'),
        orange = get_colors('orange'),
        yellow = get_colors('yellow'),
        green = get_colors('green'),
        blue = get_colors('blue'),
        cyan = get_colors('cyan'),
        purple = get_colors('purple'),
        magenta = get_colors('magenta'),
        white = get_colors('white')
    }

    local buffer = require('galaxyline.providers.buffer')
    local condition = require('galaxyline.condition')
    local fileinfo = require('galaxyline.providers.fileinfo')
    local lsp = require('galaxyline.providers.lsp')
    local vcs = require('galaxyline.providers.vcs')
    gl.short_line_list = { 'NvimTree', 'help', 'tagbar', 'toggleterm', 'Outline' }

    local mode_color = { -- {{{2
        c = colors.magenta,
        ['!'] = colors.red,
        i = colors.green,
        ic = colors.yellow,
        ix = colors.yellow,
        n = colors.blue,
        no = colors.blue,
        nov = colors.blue,
        noV = colors.blue,
        r = colors.cyan,
        rm = colors.cyan,
        ['r?'] = colors.cyan,
        R = colors.purple,
        Rv = colors.purple,
        s = colors.orange,
        S = colors.orange,
        [''] = colors.orange,
        t = colors.purple,
        v = colors.red,
        V = colors.red,
        [''] = colors.red
    }

    mode_color.get = function()
        local s = mode_color[vim.fn.mode()]
        if type(s) == 'function' then
            return s()
        else
            return s
        end
    end

    -- local mode_icon = { --- {{{2
    --     c = "🅒 ",
    --     ['!'] = "🅒 ",
    --     i = "🅘 ",
    --     ic = "🅘 ",
    --     ix = "🅘 ",
    --     n = "🅝 ",
    --     R = "🅡 ",
    --     Rv = "🅡 ",
    --     r = "🅡 ",
    --     rm = "🅡 ",
    --     ['r?'] = "🅡 ",
    --     s = "🅢 ",
    --     S = "🅢 ",
    --     [''] = "🅢 ",
    --     t = "🅣 ",
    --     v = "🅥 ",
    --     V = "🅥 ",
    --     [''] = "🅥 "
    -- }
    local mode_icon = { --- {{{2
        c = "גּ COMMAND",
        ['!'] = "גּ COMMAND",
        i = " INSERT",
        ic = " INSERT",
        ix = " INSERT",
        n = "賂NORMAL",
        R = "﯒ REPLACE",
        Rv = "﯒ REPLACE",
        r = "﯒ REPLACE",
        rm = "﯒ REPLACE",
        ['r?'] = "﯒ REPLACE",
        s = "礪SELECT",
        S = "礪SELECT",
        [''] = "礪SELECT",
        t = " TERMINAL",
        v = "礪VISUAL",
        V = "礪VISUAL",
        [''] = "礪VISUAL"
    }

    mode_icon.get = function()
        return mode_icon[vim.fn.mode()]
    end

    local num_icons = { " ", " ", " ", " ", " ", " ", " ", " ", " ", " " }
    num_icons.get = function()
        return num_icons[math.min(10, buffer.get_buffer_number())]
    end

    local function set_mode_color(group, fg)
        local x = 'guibg'
        local g = 'Galaxy' .. group
        if fg then x = 'guifg' end
        vim.cmd('hi! ' .. g .. ' ' .. x .. '=' .. mode_color.get())
    end
    --------------------
    -- left
    --------------------
    gls.left[0] = {
        ModeNum = {
            highlight = { colors.bg, mode_color.get() },
            provider = function()
                set_mode_color('ModeNum')
                -- return '  ' .. mode_icon.get() .. num_icons.get() .. ' '
                return '  ' .. mode_icon.get() .. ' '
            end
        }
    }

    gls.left[1] = {
        LFileSepL = {
            highlight = { mode_color.get(), colors.bg },
            provider = function()
                set_mode_color('LFileSepL', true)
                return ''
            end
        }
    }

    gls.left[2] = {
        FileIcon = {
            highlight = { fileinfo.get_file_icon_color(), colors.bg },
            provider = function()
                return '  ' .. fileinfo.get_file_icon()
            end
        }
    }

    gls.left[3] = {
        FileName = {
            highlight = { colors.fg, colors.bg },
            provider = function()
                local file_name = fileinfo.get_current_file_name()
                if file_name == nil or file_name:len() == 0 then return 'EMPTY ' end
                -- set_mode_color('FileInfo', true)
                return file_name
            end
        }
    }

    gls.left[4] = {
        LFileSepR = {
            highlight = { mode_color.get(), colors.bg },
            provider = function()
                set_mode_color('LFileSepR', true)
                -- return ''
                return ''
            end
        }
    }

    gls.left[5] = {
        GitIcon = {
            condition = condition.check_git_workspace,
            highlight = { colors.orange, colors.bg },
            provider = function()
                return '  '
            end
        }
    }

    -- git branch
    gls.left[6] = {
        GitBranch = {
            condition = condition.check_git_workspace,
            highlight = { colors.fg, colors.bg },

            provider = function()
                local branch = vcs.get_git_branch()
                if (branch == nil) then branch = '???' end
                return '  ' .. branch .. ' '
            end
        }
    }

    -- git add
    gls.left[7] = {
        DiffAdd = {
            highlight = { colors.green, colors.bg },
            provider = function()
                local r = vcs.diff_add()
                if r then return ' ' .. r end
            end
        }
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
                if r then return ' ' .. r end
            end
        }
    }

    -- git remove
    gls.left[9] = {
        DiffRemoved = {
            highlight = { colors.red, colors.bg },
            provider = function()
                local r = vcs.diff_remove()
                if r then return ' ' .. r end
            end
        }
    }

    --------------------
    -- mid
    --------------------
    gls.mid[0] = {
        Empty = {
            hilight = { nil, nil },
            provider = function()
                return ''
            end
        }
    }
    --------------------
    -- right
    --------------------
    gls.right[0] = {
        LspClient = { -- {{{2
            highlight = { colors.fg, colors.bg },
            provider = function()
                local icon = '   '
                local active_lsp = lsp.get_lsp_client()
                if active_lsp == 'No Active Lsp' then return '' end
                return icon .. active_lsp .. ' ' .. (lsp_status.status_progress())
            end
        }
    }

    gls.right[1] = {
        DiagnosticError = {
            highlight = { colors.red, colors.bg },
            provider = function()
                local icon = ' '
                local count = vim.lsp.diagnostic.get_count(0, 'Error')
                if count == 0 then return '' end
                return icon .. count .. ' '
            end
        }
    }

    gls.right[2] = {
        DiagnosticWarn = {
            highlight = { colors.yellow, colors.bg },
            provider = function()
                local icon = ' '
                local count = vim.lsp.diagnostic.get_count(0, 'Warning')
                if count == 0 then return '' end
                return icon .. count .. ' '
            end
        }
    }

    gls.right[3] = {
        DiagnosticHint = {
            highlight = { colors.cyan, colors.bg },
            provider = function()
                local icon = ' '
                local count = vim.lsp.diagnostic.get_count(0, 'Hint')
                if count == 0 then return '' end
                return icon .. count .. ' '
            end
        }
    }

    gls.right[4] = {
        RFileSepL = {
            highlight = { mode_color.get(), colors.bg },
            provider = function()
                set_mode_color('RFileSepL', true)
                return '  '
            end
        }
    }

    gls.right[5] = {
        FileInfo = {
            highlight = { colors.fg, colors.bg },
            provider = function()
                local format_icon = { ['DOS'] = " ", ['MAC'] = " ", ['UNIX'] = " " }
                local encode = fileinfo.get_file_encode()
                local format = fileinfo.get_file_format()
                set_mode_color('FileInfo', true)
                return ' ' .. encode .. ' ' .. format_icon[format]
            end
        }
    }

    gls.right[6] = {
        RFileSepR = {
            highlight = { mode_color.get(), colors.bg },
            provider = function()
                set_mode_color('RFileSepR', true)
                return ''
            end
        }
    }

    gls.right[7] = {
        LineInfo = {
            highlight = { colors.bg, mode_color.get() },
            provider = function()
                set_mode_color('LineInfo')
                local cursor = vim.api.nvim_win_get_cursor(0)
                return '   ' .. cursor[1] .. '/' .. vim.api.nvim_buf_line_count(0) .. ':' .. cursor[2] .. ' '
            end
        }
    }

    -----------------------------
    -- short lines
    -----------------------------
    gls.short_line_left[0] = gls.left[0]
    gls.short_line_left[1] = gls.left[1]
    gls.short_line_left[2] = gls.left[2]
    gls.short_line_left[3] = gls.left[3]
    gls.short_line_right[0] = gls.right[6]

    -- for mid background
    vim.cmd([[hi! StatusLine guibg=]] .. colors.bg())
    vim.cmd([[
    autocmd ColorScheme * lua require('plugins.settings.statusline').update_status_bg()
    ]])
end

M.dyn_theme_color = function(name)
    return get_colors(name)()
end

M.update_status_bg = function()
    vim.cmd([[hi! StatusLine guibg=]] .. get_colors('bg')())
end

return M
