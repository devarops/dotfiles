require("options")     -- Set options like mapleader
require("variables")   -- Define global variables (if any)
require("plugins")     -- Load plugin manager and plugins
require("lsp")         -- Setup LSP (which might define commands used in mappings)
require("vimrc")       -- Any legacy settings from old vimrc
require("kemaps")      -- Finally load keymaps, which depend on plugins and options

