-- Customize Treesitter

---@type LazySpec
return {
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
            {
                "nvim-treesitter/nvim-treesitter-textobjects",
                lazy = true
            },
        },
        lazy = vim.fn.argc(-1) == 0, -- load treesitter immediately when opening a file from the cmdline
        cmd = {
            "TSBufDisable",
            "TSBufEnable",
            "TSBufToggle",
            "TSDisable",
            "TSEnable",
            "TSToggle",
            "TSInstall",
            "TSInstallInfo",
            "TSInstallSync",
            "TSModuleInfo",
            "TSUninstall",
            "TSUpdate",
            "TSUpdateSync",
        },
        build = ":TSUpdate",
        event = "VeryLazy",
        init = function(plugin)
            -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
            -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
            -- no longer trigger the **nvim-treeitter** module to be loaded in time.
            -- Luckily, the only thins that those plugins need are the custom queries, which we make available
            -- during startup.
            -- CODE FROM LazyVim (thanks folke!) https://github.com/LazyVim/LazyVim/commit/1e1b68d633d4bd4faa912ba5f49ab6b8601dc0c9
            require("lazy.core.loader").add_to_rtp(plugin)
            pcall(require, "nvim-treesitter.query_predicates")
        end,
        opts = function(_, opts)
            opts.auto_install = vim.fn.executable "tree-sitter" == 1
            opts.highlight = { enable = true }
            opts.incremental_selection = { enable = true }
            opts.indent = { enable = true }
            opts.folding = { enable = true }
            opts.textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        ["ac"] = { query = "@class.outer", desc = "around class" },
                        ["ic"] = { query = "@class.inner", desc = "inside class" },
                        ["af"] = { query = "@function.outer", desc = "around function " },
                        ["if"] = { query = "@function.inner", desc = "inside function " },
                        ["aa"] = { query = "@parameter.outer", desc = "around argument" },
                        ["ia"] = { query = "@parameter.inner", desc = "inside argument" },
                    },
                },
            }
            -- list like portions of a table cannot be merged naturally and require the user to merge it manually
            -- check to make sure the key exists
            if not opts.ensure_installed then opts.ensure_installed = {} end
            vim.list_extend(opts.ensure_installed, {
                "lua",
                "vim",
                "cpp",
                "python",
                -- add more arguments for adding more treesitter parsers
            })
            return opts
        end,
        config = function (_, opts)
            require 'nvim-treesitter.configs'.setup(opts)
            -- Setup autocmds for folding
        end
    },
}
