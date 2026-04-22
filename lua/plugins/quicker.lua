return {
    'stevearc/quicker.nvim',

    keys = {
        {
            "<leader>c",
            function()
                require("quicker").toggle()
            end,
            mode = "n",
            desc = "toggle quicker quickfix",
        }
    },
    ft = "qf",
    ---@module "quicker"
    ---@type quicker.SetupOptions
    opts = {
        keys = {
            {
                ">",
                function()
                    require("quicker").expand({ before = 1, after = 1, add_to_existing = true })
                end,
                desc = "Expand quickfix context",
            },
            {
                "<",
                function()
                    require("quicker").collapse()
                end,
                desc = "Collapse quickfix context",
            },
        },
    },
    config = function(_, opts)
        require("quicker").setup(opts)
    end,
}
