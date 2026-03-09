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
                    local clangd_opts = {
                            cmd = {
                                "clangd",
                                "--query-driver=/usr/bin/g++",
                                "--background-index",
                                "--background-index-priority=background",
                                "-j=12",
                                "--log=error",
                                "--clang-tidy",
                                "--enable-config",
                                "--header-insertion=never",
                                "--completion-style=detailed",
                                "--function-arg-placeholders=1",
                                "--include-ineligible-results",
                                "--limit-results=1000",
                                "--limit-references=10000",
                            },
                            init_options = {
                                usePlaceholders = true,
                                completeUnimported = true,
                                clangdFileStatus = true,
                            },
                            root_markers = { "compile_commands.json", ".clangd", ".clang-tidy", ".clang-format", "compile_flags.txt", "configure.ac", ".git" },
                        }

                    mason.setup()
                    if vim.fn.has("nvim-0.11") == 1 then
                        vim.lsp.config("clangd", clangd_opts)
                        vim.lsp.config("lua_ls", {
                            settings = {
                                Lua = {
                                    diagnostics = {
                                        globals = { "vim" }
                                    }
                                }
                            }
                        })
                        vim.lsp.config("basedpyright", {
                            settings = {
                                basedpyright = {
                                    pythonPath = "/mnt/work/repos/third_party/python/python3.10.18/linux64/bin/python3",
                                }
                            }
                        })
                    else
                        require("lspconfig").clangd.setup(clangd_opts)
                    end

                end,
            },
        },
    },
}
