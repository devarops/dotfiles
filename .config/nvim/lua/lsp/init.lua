require("nvim-lsp-installer").setup {}
local servers = {
  "pyright",
  "r_language_server",
  "sumneko_lua",
}
local lspconfig = require("lspconfig")
for _, lsp in pairs(servers) do
  local server_configuration = require("lsp." .. lsp)
  lspconfig[lsp].setup(server_configuration)
end
