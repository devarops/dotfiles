require("nvim-lsp-installer").setup({
    automatic_installation = true
})
local servers = {
    "pyright",
    "r_language_server",
    "sumneko_lua",
}

local function is_file(filename)
    local file = io.open(filename, "r")
    if file ~= nil then io.close(file) return true else return false end
end

local function get_lsp_configuration(lsp)
    local lsp_config_filename = os.getenv("HOME") .. "/.config/nvim/lua/lsp/" .. lsp .. ".lua"
    if is_file(lsp_config_filename) then
        print("Loaded " .. lsp .. " configuration")
        return require("lsp." .. lsp)
    end
    print("No configuration found for " .. lsp)
    return {}
end

local lspconfig = require("lspconfig")
for _, lsp in pairs(servers) do
    local lsp_configuration = get_lsp_configuration(lsp)
    lspconfig[lsp].setup(lsp_configuration)
end
