vim.pack.add({ 'https://github.com/folke/which-key.nvim' })

require('which-key').setup({})

vim.keymap.set('n', '<leader>?', function()
  require('which-key').show({ global = false })
end, { desc = 'Buffer Local Keymaps (which-key)' })

require('which-key').add({
  { '<leader>f', group = '[F]ind using Telescope' },
  { '<leader>p', group = '[P]rogramming environment' },
})
