--- Keep at most one pane visible per exclusive region.
---
--- Which panes exist is read from edgy's own config (each view's `ft` and
--- `filter`), so a pane added to `plugins.edgy.views` takes part automatically
--- and nothing here knows about specific plugins. A view can opt out with
--- `exclusive = false` in its own opts.
local title = require("plugins.edgy.title")

-- Regions that show at most one edgy view at a time.
local REGIONS = { "left", "bottom" }

-- The edgebar for a position, or nil when edgy has not built it yet.
local function edgebar(pos)
    local layout = require("edgy.config").layout
    local eb = layout and layout[pos]
    return eb and eb.views and eb or nil
end

-- The view that owns `buf` in `pos`, mirroring how edgy itself decides
-- membership: same filetype, plus the view's filter when it has one. Views
-- sharing a filetype (neo-tree's filesystem / buffers / git_status) are told
-- apart by their filters, so they count as different panes without any
-- hardcoded source names.
local function view_for(pos, buf, win)
    local eb = edgebar(pos)
    if not eb then
        return nil
    end
    local ft = vim.bo[buf].filetype
    for _, view in ipairs(eb.views) do
        if view.exclusive ~= false
            and view.ft == ft
            and (not view.filter or (win ~= nil and view.filter(buf, win)))
        then
            return view
        end
    end
    return nil
end

-- Cheap pre-check used at event time: does any exclusive-region view declare
-- this buffer's filetype? Filters are ignored here on purpose, because they
-- may read window variables that the plugin sets only after the window appears
-- (snacks.nvim terminal does), so evaluating them this early would wrongly
-- discard the event.
local function candidate(buf)
    if not vim.api.nvim_buf_is_valid(buf) then
        return false
    end
    local ft = vim.bo[buf].filetype
    for _, pos in ipairs(REGIONS) do
        local eb = edgebar(pos)
        for _, view in ipairs(eb and eb.views or {}) do
            if view.exclusive ~= false and view.ft == ft then
                return true
            end
        end
    end
    return false
end

-- Close every other window in `pos`, keeping only `keep_win`. The region is
-- exclusive regardless of which view a window belongs to, so two windows of
-- the same view (e.g. two terminals) also collapse to one.
local function keep_only(pos, keep_win)
    local eb = edgebar(pos)
    -- iterate a copy: Win:close() removes itself from `eb.wins`, and mutating
    -- the list mid-loop would skip entries
    for _, entry in ipairs(vim.list_extend({}, eb and eb.wins or {})) do
        if entry.win ~= keep_win and vim.api.nvim_win_is_valid(entry.win) then
            entry:close()
        end
    end
end

-- Enforce the exclusive regions for one window. Returns the set of regions the
-- window belongs to.
local function enforce(win, buf)
    local handled = {}
    if win == nil or win <= 0 or not vim.api.nvim_buf_is_valid(buf) then
        return handled
    end
    if not vim.api.nvim_win_is_valid(win) or vim.api.nvim_win_get_buf(win) ~= buf then
        return handled
    end

    for _, pos in ipairs(REGIONS) do
        if view_for(pos, buf, win) then
            handled[pos] = true
            keep_only(pos, win)
        end
    end
    return handled
end

-- Record the active pane for the title. Only panes that declare `sidebar`
-- metadata take part, so the winbar and the highlight groups derived from it
-- stay in sync with `plugins.edgy.views`.
local function update_active_sidebar(win, buf)
    if win == nil or not vim.api.nvim_win_is_valid(win) then
        return
    end
    if not vim.api.nvim_buf_is_valid(buf) then
        return
    end

    local view = view_for("left", buf, win)
    if not view or not view.sidebar or view.title ~= title.get_title then
        return
    end

    title.set_active(view)
end

local function enforce_and_track(win, buf)
    local handled = enforce(win, buf)
    if not handled.left then
        return false
    end
    update_active_sidebar(win, buf)
    return true
end

-- Deferred with `vim.schedule` so edgy has laid the new window out and the
-- plugin has finished initialising the pane. The window that is focused at
-- that moment wins, so a burst of panes opening in a row converges on the last
-- one instead of closing a pane that was just opened; the event's own window
-- is only pruned, never used for the title, since it may not be focused.
local function on_layout_event(event)
    if not package.loaded.edgy then
        return
    end

    local buf = event.buf
    local win = event.win
    if win == nil or win <= 0 then
        win = vim.fn.bufwinid(buf)
        if win < 0 then
            win = nil
        end
    end

    local cur_win = vim.api.nvim_get_current_win()
    local cur_buf = vim.api.nvim_win_get_buf(cur_win)
    if not (candidate(buf) or candidate(cur_buf)) then
        return
    end

    vim.schedule(function()
        if enforce_and_track(cur_win, cur_buf) then
            return
        end
        enforce(win, buf)
    end)
end

local M = {}

--- Register the autocmds that keep the exclusive regions single-pane.
function M.setup()
    -- Several triggers are needed because plugins differ in when the pane
    -- becomes recognisable: neo-tree sets the filetype before the window is
    -- shown, while outline.nvim focuses an existing window and assigns the
    -- filetype afterwards. All triggers funnel into the same idempotent pass,
    -- so extra events are harmless.
    vim.api.nvim_create_autocmd("BufWinEnter", { pattern = "*", callback = on_layout_event })
    vim.api.nvim_create_autocmd("BufEnter", { pattern = "*", callback = on_layout_event })
    vim.api.nvim_create_autocmd("WinEnter", { pattern = "*", callback = on_layout_event })
    vim.api.nvim_create_autocmd("FileType", { pattern = "*", callback = on_layout_event })
end

return M
