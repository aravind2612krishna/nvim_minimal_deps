return {
    "olimorris/codecompanion.nvim",
    version = "^19.0.0",
    cmd = { "CodeCompanionChat", "CodeCompanionInline", "CodeCompanionCmd", "CodeCompanionBackground" },
    opts = {
        chat = {
            -- You can specify an adapter by name and model (both ACP and HTTP)
            adapter = {
                name = "copilot",
                model = "claude-sonnet-4.6",
            },
        },
        -- Or, just specify the adapter by name
        inline = {
            adapter = {
                name = "copilot",
                model = "claude-sonnet-4.6",
            },
        },
        cmd = {
            adapter = {
                name = "copilot",
                model = "claude-sonnet-4.6",
            },
        },
        background = {
            adapter = {
                name = "copilot",
                model = "claude-sonnet-4.6",
            },
        },
    },
    config = true,
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
}
