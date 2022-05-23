local _MODULE = {}

function _MODULE.pair()
    vim.opt.relativenumber = false
    vim.cmd("colorscheme slate")
end

function _MODULE.solo()
    vim.opt.relativenumber = true
    vim.cmd("colorscheme gruvbox")
end

return _MODULE
