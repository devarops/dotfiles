return require('packer').startup(function(use)
  use 'gruvbox-community/gruvbox'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/vim-vsnip'
  use 'itchyny/lightline.vim'
  use 'jalvesaq/Nvim-R'
  use 'mengelbrecht/lightline-bufferline'
  use 'neovim/nvim-lspconfig'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-treesitter/nvim-treesitter'
  use 'wbthomason/packer.nvim'
  use 'williamboman/nvim-lsp-installer'

  require('packer').sync()
end)
