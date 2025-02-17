local M = {}

function M.is_fully_supported()
    if os.getenv("TERM_PROGRAM") == "WezTerm" then
        return true
    end

    if os.getenv("TERM") == "xterm-kitty" then
        return true
    end

    if os.getenv("TERM") == "xterm-ghostty" then
        return true
    end

    return false
end

function M.is_iterm()
    return os.getenv("TERM_PROGRAM") == "iTerm.app"
end

function M.is_ssh_session()
    return os.getenv("SSH_TTY") ~= nil or os.getenv("SSH_CLIENT") ~= nil or os.getenv("SSH_CONNECTION") ~= nil
end

return M
