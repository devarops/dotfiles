vim.g.copilot_assume_mapped = true
vim.api.nvim_set_keymap("i", "<M-\\>", 'copilot#Accept("")', { silent = true, expr = true })
