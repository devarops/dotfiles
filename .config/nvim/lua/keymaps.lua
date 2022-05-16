local options = { noremap = true, silent = true}
local keymap = vim.api.nvim_set_keymap

-- Cuando pegues en visual mode, deja en el registry el valor que pegaste
keymap("n", "<C-j>", "<cmd>bnext<CR>", options)
keymap("n", "<C-k>", "<cmd>bprevious<CR>", options)
keymap("v", "p", '"_dP', options)


