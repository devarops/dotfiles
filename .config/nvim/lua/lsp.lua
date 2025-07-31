vim.lsp.config('*', {
  root_markers = { '.git' },
})

vim.lsp.enable(
  'r_language_server'
)

-- Enable LSP complition: https://gpanders.com/blog/whats-new-in-neovim-0-11/#builtin-auto-completion
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
  end,
})

-- Enable virtual lines for diagnostics: https://gpanders.com/blog/whats-new-in-neovim-0-11/#virtual-text-handler-changed-from-opt-out-to-opt-in
vim.diagnostic.config({
  virtual_lines = {
    current_line = true,
  },
})
