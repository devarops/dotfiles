local use = require("packer").use
require("packer").startup(function()
  use "gruvbox-community/gruvbox"          --
  use "hrsh7th/cmp-buffer"                 --
  use "hrsh7th/cmp-cmdline"                --
  use "hrsh7th/cmp-nvim-lsp"               --
  use "hrsh7th/cmp-path"                   --
  use "hrsh7th/cmp-vsnip"                  --
  use "hrsh7th/nvim-cmp"                   --
  use "hrsh7th/vim-vsnip"                  --
  use "itchyny/lightline.vim"              --
  use "jalvesaq/Nvim-R"                    --
  use "mengelbrecht/lightline-bufferline"  --
  use "nvim-lua/plenary.nvim"              --
  use "nvim-telescope/telescope.nvim"      --
  use "nvim-treesitter/nvim-treesitter"    --
  use "wbthomason/packer.nvim"             -- Package manager

  -- Language Server Protocol (LSP)
  use {
    "williamboman/nvim-lsp-installer",
    {
      "neovim/nvim-lspconfig",
      config = function()
        require("nvim-lsp-installer").setup {
          automatic_installation = true, -- automatically detect which servers to install
        }
        local servers = {
          "pyright",
          "r_language_server",
          "sumneko_lua",
        }
        local lspconfig = require("lspconfig")
        for _, lsp in pairs(servers) do
          lspconfig[lsp].setup {}
        end
      end
    }
  }

  require("packer").sync()
end)
