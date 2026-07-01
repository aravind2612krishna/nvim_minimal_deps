return {
    "leolaurindo/tunnelvision.nvim",
    opts = {},
    cmd = "TunnelVision",
    config = true,
    keys = {
        {
            "<leader>f",
            function() require("tunnelvision").toggle() end,
            mode = "n",
            desc = "TunnelVision [f]ocus on current word",
        },
        {
            "<M-n>",
            function() require("tunnelvision").next() end,
            mode = "n",
            desc = "TunnelVision next",
        },
        {
            "<M-p>",
            function() require("tunnelvision").prev() end,
            mode = "n",
            desc = "TunnelVision prev",
        },
    },
}
