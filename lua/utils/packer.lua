local function load_plugin(name)
    if not packer_plugins[name].loaded then
        require("packer").loader(name)
    end
end

return {
    load_plugin = load_plugin,
}
