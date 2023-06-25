local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Example using a list of specs with the default options
vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct

require("lazy").setup({
  "folke/which-key.nvim",             -- Display available keybindings
  "github/copilot.vim",               --
  "gruvbox-community/gruvbox",        --
  "williamboman/mason.nvim",          --
  "williamboman/mason-lspconfig.nvim",--
  "hrsh7th/cmp-buffer",   --
  "hrsh7th/cmp-cmdline",  --
  "hrsh7th/cmp-nvim-lsp", --
  "hrsh7th/cmp-path",     --
  "hrsh7th/cmp-vsnip",    --
  "hrsh7th/nvim-cmp",     --
  "hrsh7th/vim-vsnip",    --
  "itchyny/lightline.vim",--
  "jalvesaq/Nvim-R",      --
  "mengelbrecht/lightline-bufferline",--
  "navarasu/onedark.nvim",            -- Theme inspired by Atom
  "neovim/nvim-lspconfig",            --
  "nvim-lua/plenary.nvim",            -- Dependencie of nvim-telescope/telescope.nvim
  "nvim-telescope/telescope.nvim",    --
  "nvim-treesitter/nvim-treesitter",  --
  "wbthomason/packer.nvim",           -- Plugin manager
  "whonore/vim-sentencer",            -- One sentence per line and wrap long lines
})

require("plugins.treesitter")
require("plugins.cmp")
require("plugins.lightline-bufferline")
require("plugins.copilot")
require("plugins.sentencer")
require("plugins.which-key")


