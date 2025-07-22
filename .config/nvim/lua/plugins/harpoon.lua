return {
  "ThePrimeagen/harpoon",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon_ui = require("harpoon.ui")
    local harpoon_mark = require("harpoon.mark")
    local harpoon = require("harpoon")
  end,
}
