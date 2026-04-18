-- Neovim integration for opencode
vim.pack.add({
  'https://github.com/nickjvandyke/opencode.nvim',
})

---@type opencode.Opts
vim.g.opencode_opts = {
  -- Your configuration, if any; goto definition on the type or field for details
}

vim.o.autoread = true -- Required for `opts.events.reload`
