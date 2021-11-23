call plug#begin()
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
Plug 'gruvbox-community/gruvbox'
Plug 'itchyny/lightline.vim'
Plug 'jalvesaq/Nvim-R', {'branch': 'stable'}
Plug 'lifepillar/vim-mucomplete'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'voldikss/vim-floaterm'
call plug#end()

source ~/.config/nvim/gruvbox.vim
source ~/.config/nvim/lightline-bufferline.vim
source ~/.config/nvim/telescope.vim
source ~/.config/nvim/vim-floaterm.vim
source ~/.config/nvim/vim-mucomplete.vim
source ~/.vimrc
