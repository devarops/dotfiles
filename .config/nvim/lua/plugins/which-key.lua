local which_key = require("which-key")
which_key.setup {}
which_key.add({
  { "<leader>f", group = "[F]ind using Telescope" },
  { "<leader>g", group = "[G]it" },
  { "<leader>p", group = "[P]rogramming environment" },
})
