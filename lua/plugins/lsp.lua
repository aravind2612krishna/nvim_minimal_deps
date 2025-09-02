return {
    {
        "mason-org/mason-lspconfig.nvim",
        lazy = false,
        opts = {
            ensure_installed = { "lua_ls" },
        },
        dependencies = {
            { "mason-org/mason.nvim", opts = {} },
            {
                "neovim/nvim-lspconfig",
                lazy = false,
                dependencies = {
                    "williamboman/mason.nvim",
                },
                config = function()
                    local mason = require("mason")

                    mason.setup()
                    if vim.fn.has("nvim-0.12") == 1 then
                        vim.lsp.config("clangd", {
                            cmd = {
                                "clangd",
                                "--background-index",
                                "-j=10",
                                "--clang-tidy",
                                "--enable-config",
                                "--header-insertion=never",
                                "--completion-style=detailed",
                                "--function-arg-placeholders",
                                "--include-ineligible-results",
                            },
                            init_options = {
                                usePlaceholders = true,
                                completeUnimported = true,
                                clangdFileStatus = true,
                            },
                        })
                        vim.lsp.config("lua_ls", {
                            settings = {
                                Lua = {
                                    diagnostics = {
                                        globals = { "vim" }
                                    }
                                }
                            }
                        })
                    end

                end,
            },
        },
    },
}
