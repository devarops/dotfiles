require("mason").setup()
require("mason-lspconfig").setup()
local servers = {
    "lua_ls",
    "pyright",
    "r_language_server",
}

local function is_file(filename)
    local file = io.open(filename, "r")
    if file ~= nil then io.close(file) return true else return false end
end

local function get_lsp_configuration(lsp)
    local lsp_config_filename = os.getenv("HOME") .. "/.config/nvim/lua/lsp/" .. lsp .. ".lua"
    if is_file(lsp_config_filename) then
        return require("lsp." .. lsp)
    end
    return {}
end

local lspconfig = require("lspconfig")
for _, lsp in pairs(servers) do
    local lsp_configuration = get_lsp_configuration(lsp)
    lspconfig[lsp].setup(lsp_configuration)
end
