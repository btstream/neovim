local M = {}

function M.is_wezterm_or_kitty()
    if os.getenv("TERM_PROGRAM") == "WezTerm" then
        return true
    end

    if os.getenv("TERM") == "xterm-kitty" then
        return true
    end

    return false
end

function M.is_iterm()
    return os.getenv("TERM_PROGRAM") == "iTerm.app"
end

return M
