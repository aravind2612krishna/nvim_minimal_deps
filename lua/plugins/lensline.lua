return {
    {
        'oribarilan/lensline.nvim',
        tag = '2.0.0', -- or: branch = 'release/2.x' for latest non-breaking updates
        event = 'LspAttach',
        opts = {
            -- Profile definitions, first is default
            profiles = {
                {
                    name = "informative",
                    providers = {
                        { name = "usages",      enabled = true, include = { "refs", "defs", "impls" }, breakdown = true },
                        { name = "diagnostics", enabled = true, min_level = "HINT" },
                        { name = "complexity",  enabled = true }
                    },
                    style = { render = "focused", placement = "inline" },
                },
                {
                    name = "basic",
                    providers = {
                        { name = "usages",      enabled = true, include = { "refs" }, breakdown = false },
                        { name = "last_author", enabled = true }
                    },
                    style = { render = "all", placement = "inline" }
                },
            },
        },
        config = function(_, opts)
            require("lensline").setup(opts)
        end,
    },
}
