require("nvim-treesitter.configs").setup {
  ensure_installed = {
      "bash",
      "lua",
      "python",
      "r",
  },
  sync_install = true,

  highlight = { enable = true },
  incremental_selection = { enable = true },
  indent = { enable = true, },
  textobjects = { enable = true },
}
