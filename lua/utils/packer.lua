local function ensure_loaded(name)
    local packer = require("packer")
    if type(name) == "string" and not packer_plugins[name].loaded then
        packer.loader(name)
    end

    if type(name) == "table" then
        for _, n in ipairs(name) do
            if not packer_plugins[n].loaded then
                packer.loader(n)
            end
        end
    end
end

return {
    ensure_loaded = ensure_loaded,
}
