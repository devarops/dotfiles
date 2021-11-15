call plug#begin()
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'morhetz/gruvbox'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
call plug#end()

source ~/.config/nvim/gruvbox.vim
source ~/.config/nvim/lightline-bufferline.vim
source ~/.config/nvim/telescope.vim
source ~/.vimrc
