return {
    'stevearc/conform.nvim',
    keys = {
        {
            "<leader>gq",
            function()
                require("conform").format({ lsp_format = "fallback" })
            end,
            mode = {"n", "x"},
            desc = "Conform format",
        },
    },
    opts = {
        formatters_by_ft = {
            lua = { "stylua" },
            -- Conform will run multiple formatters sequentially
            python = { "black" },
            sh = { "shfmt", "shellcheck" },
            zsh = { "shfmt", "shellcheck" },
        },
        format_on_save = false,
    },
}
