local which_key = require("which-key")
which_key.setup {}
which_key.add({
  { "<leader>f", group = "[F]ind using Telescope" },
  { "<leader>p", group = "[P]rogramming environment" },
})
