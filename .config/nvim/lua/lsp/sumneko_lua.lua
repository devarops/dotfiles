return {
  settings = {
    Lua = {
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {
            "describe",
            "it",
            "vim",
        },
      },
    },
  },
}
