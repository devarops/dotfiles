local options = { noremap = true, silent = true }

vim.keymap.set("n", "<C-j>", "<cmd>bnext<CR>", options)
vim.keymap.set("n", "<C-k>", "<cmd>bprevious<CR>", options)
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", options)
vim.keymap.set("n", "<leader>fc", "<cmd>Telescope command_history<cr>", options)
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", options)
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", options)
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", options)
vim.keymap.set("n", "<leader>pp", require("pair_programming").pair, options)
vim.keymap.set("n", "<leader>ps", require("pair_programming").solo, options)
vim.keymap.set("v", "p", '"_dP', options) -- Cuando pegues en visual mode, deja en el registry el valor que pegaste
