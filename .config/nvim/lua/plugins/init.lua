local use = require("packer").use
require("packer").startup(function()
    use "folke/which-key.nvim"              -- Display available keybindings
    use "github/copilot.vim"                --
    use "gruvbox-community/gruvbox"         --
    use "williamboman/mason.nvim"           --
    use "williamboman/mason-lspconfig.nvim" --
    use "hrsh7th/cmp-buffer"    --
    use "hrsh7th/cmp-cmdline"   --
    use "hrsh7th/cmp-nvim-lsp"  --
    use "hrsh7th/cmp-path"      --
    use "hrsh7th/cmp-vsnip"     --
    use "hrsh7th/nvim-cmp"      --
    use "hrsh7th/vim-vsnip"     --
    use "itchyny/lightline.vim" --
    use "jalvesaq/Nvim-R"       --
    use "mengelbrecht/lightline-bufferline" --
    use "neovim/nvim-lspconfig"             --
    use "nvim-lua/plenary.nvim"             -- Dependencie of nvim-telescope/telescope.nvim
    use "nvim-telescope/telescope.nvim"     --
    use "nvim-treesitter/nvim-treesitter"   --
    use "wbthomason/packer.nvim"            -- Plugin manager
    use {"whonore/vim-sentencer", branch = "preserve-cursor"} -- One sentence per line and wrap long lines

    require("packer").sync()
end)

require("plugins.treesitter")
require("plugins.cmp")
require("plugins.lightline-bufferline")
require("plugins.copilot")
require("plugins.sentencer")
require("plugins.which-key")


