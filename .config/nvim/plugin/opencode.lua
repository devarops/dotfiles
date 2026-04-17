vim.pack.add({
  -- Dependency of opencode.nvim: enhanced input and picker UI via snacks.nvim
  'https://github.com/folke/snacks.nvim',

  -- Main plugin: Neovim integration for opencode
  'https://github.com/nickjvandyke/opencode.nvim',
})

require('snacks').setup({
  input = {}, -- Enhances `ask()`
  picker = { -- Enhances `select()`
    actions = {
      opencode_send = function(...)
        return require('opencode').snacks_picker_send(...)
      end,
    },
    win = {
      input = {
        keys = {
          ['<a-a>'] = { 'opencode_send', mode = { 'n', 'i' } },
        },
      },
    },
  },
})

---@type opencode.Opts
vim.g.opencode_opts = {
  -- Your configuration, if any; goto definition on the type or field for details
}

vim.o.autoread = true -- Required for `opts.events.reload`
