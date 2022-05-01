" vim-plug automatic installation >>
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
" <<

call plug#begin()
Plug 'gruvbox-community/gruvbox'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/vim-vsnip'
Plug 'itchyny/lightline.vim'
Plug 'jalvesaq/Nvim-R', {'branch': 'stable'}
Plug 'mengelbrecht/lightline-bufferline'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'voldikss/vim-floaterm'
Plug 'williamboman/nvim-lsp-installer'
call plug#end()

source ~/.vimrc

source ~/.config/nvim/gruvbox.vim
source ~/.config/nvim/lightline-bufferline.vim
source ~/.config/nvim/nvim-cmp.vim
source ~/.config/nvim/telescope.vim
source ~/.config/nvim/vim-floaterm.vim
