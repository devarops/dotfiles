vim.g["lightline"] = {
    colorscheme = "deus",
    active = {
        left = { { "mode", "paste" }, { "readonly", "filename", "modified" } }
    },
    tabline = {
        left = { { "buffers" } },
        right = { { "" } }
    },
    component_expand = {
        buffers = "lightline#bufferline#buffers"
    },
    component_type = {
        buffers = "tabsel"
    }

}
