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
  "folke/which-key.nvim",              -- Display available keybindings
  "github/copilot.vim",                -- AI code completion
  "gruvbox-community/gruvbox",         -- Gruvbox colorscheme
  "hrsh7th/cmp-buffer",                -- Buffer completion for nvim-cmp
  "hrsh7th/cmp-cmdline",               -- Cmdline completion for nvim-cmp
  "hrsh7th/cmp-nvim-lsp",              -- LSP completion for nvim-cmp
  "hrsh7th/cmp-path",                  -- Path completion for nvim-cmp
  "hrsh7th/cmp-vsnip",                 -- VSnip completion for nvim-cmp
  "hrsh7th/nvim-cmp",                  -- Completion engine for Neovim
  "hrsh7th/vim-vsnip",                 -- Snippet engine for Neovim
  "jalvesaq/Nvim-R",                   -- R language support
  "mbbill/undotree",                   -- Persistent undo history
  "navarasu/onedark.nvim",             -- Theme inspired by Atom
  "neovim/nvim-lspconfig",             -- LSP configuration for Neovim
  "nvim-lua/plenary.nvim",             -- Dependencie of nvim-telescope/telescope.nvim
  "nvim-lualine/lualine.nvim",         -- Statusline for Neovim
  "nvim-telescope/telescope.nvim",     -- Fuzzy finder for Neovim
  "nvim-tree/nvim-web-devicons",       -- Icons for Neovim
  "nvim-treesitter/nvim-treesitter",   -- Treesitter support for Neovim
  "whonore/vim-sentencer",             -- One sentence per line and wrap long lines
  "williamboman/mason-lspconfig.nvim", -- LSP configuration for Mason
  "williamboman/mason.nvim",           -- LSP installer for Neovim
})

require("plugins.treesitter")

require("plugins.cmp")
require("plugins.copilot")
require("plugins.lualine")
require("plugins.sentencer")
require("plugins.which-key")
