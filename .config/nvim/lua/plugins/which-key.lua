local wk = require("which-key")
wk.setup {}
wk.add({
  { "<leader>f", group = "[B]uffer navigation" },
  { "<leader>f", group = "[F]ind using Telescope" },
  { "<leader>p", group = "[P]rogramming environment" },
})
