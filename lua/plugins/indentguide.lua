return {
    {
        'echasnovski/mini.indentscope',
        enabled = true,
        event = "BufEnter",
        version = '*',
        config = function()
            require('mini.indentscope').setup()
        end
    },
    {
        "nvimdev/indentmini.nvim",
        enabled = false,
        event = "BufEnter",
        config = function ()
            require("indentmini").setup({ only_current=true })
        end
    }
}
