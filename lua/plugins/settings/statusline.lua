local M = {}

local utils  = require('plugins.settings.lsp.utils')
local gl     = require('galaxyline')
local gls    = gl.section

-- functions to remap base16-themes to colors
local function get_colors(name)
    local bm = {
        bg      = 'base01',
        fg      = 'base05',
        red     = 'base08',
        orange  = 'base09',
        yellow  = 'base0A',
        green   = 'base0B',
        blue    = 'base0D',
        cyan    = 'base0C',
        purple  = 'base0E',
        magenta = 'base0E',
        white   = 'base05'
    }
    local _, b = vim.g.colors_name:find('base16')
    if b then
        return function ()
            local colors = require('base16-colorscheme').colorschemes[vim.g.colors_name:sub(b+2)]
            return colors[bm[name]]
        end
    else
        return require('galaxyline.themes.colors').get_color(name)
    end
end

M.setup = function()
    local colors = {
        bg      = get_colors('bg'),
        fg      = get_colors('fg'),
        red     = get_colors('red'),
        orange  = get_colors('orange'),
        yellow  = get_colors('yellow'),
        green   = get_colors('green'),
        blue    = get_colors('blue'),
        cyan    = get_colors('cyan'),
        purple  = get_colors('purple'),
        magenta = get_colors('magenta'),
        white   = get_colors('white')
    }

    local buffer    = require('galaxyline.providers.buffer')
    local condition = require('galaxyline.condition')
    local fileinfo  = require('galaxyline.providers.fileinfo')
    local lsp       = require('galaxyline.providers.lsp')
    local vcs       = require('galaxyline.providers.vcs')
    gl.short_line_list = {'NvimTree', 'help', 'tagbar', 'toggleterm', 'Outline'}


    local mode_color = { -- {{{2
        c  = colors.magenta, ['!'] = colors.red,
        i  = colors.green,   ic    = colors.yellow, ix     = colors.yellow,
        n  = colors.blue,
        no = colors.blue,    nov   = colors.blue,   noV    = colors.blue,
        r  = colors.cyan,    rm    = colors.cyan,   ['r?'] = colors.cyan,
        R  = colors.purple,  Rv    = colors.purple,
        s  = colors.orange,  S     = colors.orange, [''] = colors.orange,
        t  = colors.purple,
        v  = colors.red,     V     = colors.red,    [''] = colors.red,
    }

    mode_color.get = function ()
        local s = mode_color[vim.fn.mode()]
        if type(s) == 'function' then
            return s()
        else
            return s
        end
    end

    local mode_icon = { --- {{{2
        c = "🅒 ", ['!'] = "🅒 ",
        i = "🅘 ", ic    = "🅘 ", ix     = "🅘 ",
        n = "🅝 ",
        R = "🅡 ", Rv    = "🅡 ",
        r = "🅡 ", rm    = "🅡 ", ['r?'] = "🅡 ",
        s = "🅢 ", S     = "🅢 ", [''] = "🅢 ",
        t = "🅣 ",
        v = "🅥 ", V     = "🅥 ", [''] = "🅥 ",
    }

    mode_icon.get = function ()
        return mode_icon[vim.fn.mode()]
    end

    local num_icons = {" ", " ", " ", " ", " ", " ", " ", " ", " ", " "}
    num_icons.get = function ()
        return num_icons[math.min(10, buffer.get_buffer_number())]
    end

    local function set_color(group, fg)
        local x = 'guibg'
        local g = 'Galaxy' .. group
        if fg then
            x = 'guifg'
        end
        vim.cmd('hi! ' .. g .. ' '.. x .. '=' .. mode_color.get())
    end
    --------------------
    --left
    --------------------
    gls.left[0] = {
        ModeNum = {
            highlight = {colors.bg, mode_color.get()},
            provider = function ()
                set_color('ModeNum')
                return '  ' .. mode_icon.get() .. num_icons.get() .. ''
            end
        }
    }

    -- gls.left[1] = {
    --     FileIcon = {
    --         highlight = {fileinfo.get_file_icon_color, colors.bg},
    --         provider  = function ()
    --             return '  ' .. fileinfo.get_file_icon()
    --         end
    --     }
    -- }
    --
    -- gls.left[2] = {
    --     FileName = {
    --         highlight = {colors.fg, colors.bg},
    --         provider = function ()
    --             return fileinfo.get_current_file_name()
    --         end
    --     }
    -- }

    gls.left[1] = {
        GitIcon = {
            condition = condition.check_git_workspace,
            highlight = {colors.orange, colors.bg},
            provider = function()
                return '  '
            end
        }
    }

    -- git branch
    gls.left[2] = {
        GitBranch = {
            condition = condition.check_git_workspace,
            highlight = {colors.fg, colors.bg, 'bold'},

            provider = function ()
                local branch = vcs.get_git_branch()
                if (branch == nil) then
                    branch = '???'
                end
                return '  '..branch..' '
            end,
        }
    }

    -- git add
    gls.left[3] = {
        DiffAdd = {
            condition = function ()
                return vcs.diff_add() ~= nil
            end,
            highlight = {colors.green, colors.bg},
            provider = function ()
                local r = vcs.diff_add()
                if r then
                    return ' '..r
                end
            end
        }
    }

    -- git remove
    gls.left[4] = {
        DiffModified = {
            condition = function () 
                return vcs.diff_modified() ~= nil
            end,
            highlight = {colors.blue, colors.bg},
            provider = function ()
                local r = vcs.diff_modified()
                if r then
                    return ' '..r
                end
            end
        }
    }

    -- git remove
    gls.left[5] = {
        DiffRemoved = {
            condition = function ()
                return vcs.diff_remove() ~= nil
            end,
            highlight = {colors.red, colors.bg},
            provider = function ()
                local r = vcs.diff_remove()
                if r then
                    return ' '..r
                end
            end
        }
    }

    gls.left[6] = {
        DiagnosticError = {
            highlight = {colors.red, colors.bg, 'bold'},
            condition = function ()
                return vim.lsp.diagnostic.get_count(0, 'Error') ~= 0
            end,
            provider = function ()
                local icon = ' '
                local count = vim.lsp.diagnostic.get_count(0, 'Error')
                return icon..count..' '
            end,
        }
    }

    gls.left[7] = { DiagnosticWarn = { -- {{{2
        highlight = {colors.yellow, colors.bg, 'bold'},
        condition = function ()
            return vim.lsp.diagnostic.get_count(0, 'Warning') ~= 0
        end,
        provider = function ()
            local icon = ' '
            local count = vim.lsp.diagnostic.get_count(0, 'Warning')
            return icon..count..' '
        end,
    }}

    gls.left[8] = { DiagnosticHint = { -- {{{2
        highlight = {colors.cyan, colors.bg, 'bold'},
        condition = function ()
            return vim.lsp.diagnostic.get_count(0, 'Hint') ~= 0
        end,
        provider = function ()
            local icon = ' '
            local count = vim.lsp.diagnostic.get_count(0, 'Hint')
            return icon..count..' '
        end,
    }}

    -- gls.left[9] = {
    --     RightSep = {
    --         highlight = {mode_color.get(), colors.bg},
    --         provider = function ()
    --             set_color('RightSep', true)
    --             return ''
    --         end
    --     }
    -- }
    --------------------
    --mid
    --------------------
    gls.mid[0] = {
        Empty = {
            hilight = {colors.bg, colors.bg},
            provider = function () end
        }
    }
    --------------------
    --right
    --------------------
    gls.right[0] = {
        LspClient = { -- {{{2
            highlight = {colors.fg, colors.bg, 'bold'},
            provider = function ()
                local icon = '   '
                local active_lsp = lsp.get_lsp_client()
                if active_lsp == 'No Active Lsp' then
                    icon = ''
                    active_lsp  = ''
                end
                return icon..active_lsp..' '..(utils.get_lsp_progress())
            end,
        }
    }

    gls.right[1] = {
        FileEF = { -- {{{2
            highlight = {colors.bg, colors.cyan, 'bold'},
            provider = function ()
                local format_icon = {['DOS'] = " ", ['MAC'] = " ", ['UNIX'] = " "}
                local encode      = fileinfo.get_file_encode()
                local format      = fileinfo.get_file_format()

                -- set_color('FileEF')
                return ' '..encode..' '..format_icon[format]
            end,
        }
    }

    gls.right[2] = {
        LineInfo = { -- {{{2
            highlight = {colors.bg, mode_color.get(), 'bold'},
            provider = function ()
                set_color('LineInfo')
                local cursor = vim.api.nvim_win_get_cursor(0)
                return '   '..cursor[1]..'/'..vim.api.nvim_buf_line_count(0)..':'..cursor[2]
            end,
        }
    }
end

return M
