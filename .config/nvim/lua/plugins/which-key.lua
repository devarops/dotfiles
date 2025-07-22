local which_key = require("which-key")
which_key.setup {}
which_key.add({
  { "<leader>b", group = "[B]uffer navigation" },
  { "<leader>f", group = "[F]ind using Telescope" },
  { "<leader>p", group = "[P]rogramming environment" },
})
