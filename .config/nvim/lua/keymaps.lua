local options = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

keymap("n", "<C-j>", "<cmd>bnext<CR>", options)
keymap("n", "<C-k>", "<cmd>bprevious<CR>", options)
keymap("n", "<Down>", "<Nop>", options)
keymap("n", "<Left>", "<Nop>", options)
keymap("n", "<Right>", "<Nop>", options)
keymap("n", "<Up>", "<Nop>", options)
keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>", options)
keymap("n", "<leader>fc", "<cmd>Telescope command_history<cr>", options)
keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", options)
keymap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", options)
keymap("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", options)
keymap("v", "p", '"_dP', options) -- Cuando pegues en visual mode, deja en el registry el valor que pegaste
