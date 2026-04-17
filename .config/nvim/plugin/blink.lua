vim.pack.add({
  'https://github.com/rafamadriz/friendly-snippets',
  {
    src = 'https://github.com/saghen/blink.cmp',
    version = vim.version.range('1.x'),
  },
})

require('blink.cmp').setup({
  keymap = { preset = 'default' },
  appearance = {
    nerd_font_variant = 'mono',
  },
  completion = { documentation = { auto_show = true } },
  signature = { enabled = true },
  fuzzy = { implementation = 'prefer_rust_with_warning' },
})
