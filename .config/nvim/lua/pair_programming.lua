local _MODULE = {}

function _MODULE.pair()
    vim.cmd("colorscheme onedark")
    vim.opt.number = true
    vim.opt.relativenumber = false
end

function _MODULE.solo()
    vim.cmd("colorscheme gruvbox")
    vim.opt.number = true
    vim.opt.relativenumber = true
end

function _MODULE.tty()
    vim.cmd("colorscheme elflord")
    vim.opt.number = false
    vim.opt.relativenumber = false
end

return _MODULE

