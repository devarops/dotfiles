local _MODULE = {}

function _MODULE.pair()
    vim.cmd("colorscheme slate")
    vim.opt.number = true
    vim.opt.relativenumber = false
end

function _MODULE.solo()
    vim.cmd("colorscheme retrobox")
    vim.opt.number = true
    vim.opt.relativenumber = true
end

function _MODULE.tty()
    vim.cmd("colorscheme elflord")
    vim.opt.number = false
    vim.opt.relativenumber = false
end

return _MODULE

