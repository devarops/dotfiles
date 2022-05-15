local options = { noremap = true, silent = true}
local keymap = vim.api.nvim_set_keymap

-- Cuando pegues en visual mode, deja en el registry el valor que pegaste
keymap("v", "p", '"_dP', options)
