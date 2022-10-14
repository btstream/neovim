local function load_plugin(name)
    if not packer_plugins[name].loaded then
        require("packer").loader(name)
    end
end

return {
    ensure_load = load_plugin,
}
