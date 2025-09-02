return {
    {
        'echasnovski/mini.indentscope',
        enabled = false,
        event = "BufEnter",
        version = '*',
        config = function()
            require('mini.indentscope').setup()
        end
    },
    {
        "nvimdev/indentmini.nvim",
        enabled = true,
        event = "BufEnter",
        config = function ()
            require("indentmini").setup({ only_current=true })
        end
    }
}
