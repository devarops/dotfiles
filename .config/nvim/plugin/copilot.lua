-- GitHub Copilot is an AI pair programmer tool that helps you write code faster and smarter.
vim.pack.add({ 'https://github.com/github/copilot.vim' })

-- Use the real Node.js binary directly instead of the snap wrapper,
-- because the snap shim (/snap/bin/node -> /usr/bin/snap) doesn't pass
-- stdio correctly inside this Docker environment, breaking LSP communication.

-- Disable npx: forces the plugin to use the local script path instead.
-- This avoids the broken snap shim for npx.
vim.g.copilot_npx_command = {}

-- Point to the real Node.js binary inside the snap, bypassing the snap
-- shim wrapper entirely.
vim.g.copilot_node_command = '/snap/node/current/bin/node'
