local options = {
    colorcolumn = "100,150",
    completeopt = { "menu", "menuone", "noselect", "popup" },
    expandtab = true,      -- convert tabs to spaces
    linebreak = true,      -- wrap lines at word boundaries
    list = true,           -- show whitespace characters
    listchars = { tab = "» ", extends = ">", precedes = "<", trail = "·" },
    number = true,         -- set numbered lines
    relativenumber = true, -- set relative numbered lines
    scrolloff = 10,        -- keep 10 lines above and below the cursor
    shiftwidth = 2,        -- number of spaces to use for each step of (auto)indent
    showmode = false,      -- disable showing mode in command line
    showtabline = 2,       -- always show tabline
    signcolumn = "yes",    -- always show sign column
    smartcase = true,      -- enable smart case sensitivity in search
    softtabstop = 2,       -- number of spaces to use for a tab
    swapfile = false,      -- disable swap file creation
    tabstop = 2,           -- number of spaces that a <Tab> counts for
    termguicolors = true,  -- set terminal GUI colors
    textwidth = 100,       -- maximum width of text before wrapping
    timeoutlen = 300,      -- time to wait for a mapped sequence to complete (in milliseconds)
    winborder = "rounded", -- use rounded borders for floating windows
    wrap = false,          -- disable line wrapping
}

for key, value in pairs(options) do
    vim.opt[key] = value
end

vim.opt["formatoptions"]:remove("t") -- Do not auto-wrap text using textwidth
vim.opt["iskeyword"]:append("-") -- Define compound words separated with hyphen as a single word
