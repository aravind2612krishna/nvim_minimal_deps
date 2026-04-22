-- Customize Treesitter

---@type LazySpec
return {
    {
        "nvim-treesitter/nvim-treesitter",
        main = "nvim-treesitter.config",
        lazy = false, -- ensure treesitter loads immediately for debugging
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
            require 'nvim-treesitter.config'.setup(opts)
            -- Setup autocmds for folding
        end
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
        keys = {
            {
                "aa",
                function()
                    require "nvim-treesitter-textobjects.select".select_textobject("@parameter.outer", "textobjects")
                end,
                mode = { "x", "o" },
                desc = "Select outer parameter textobject"
            },
            {
                "ia",
                function()
                    require "nvim-treesitter-textobjects.select".select_textobject("@parameter.inner", "textobjects")
                end,
                mode = { "x", "o" },
                desc = "Select inner parameter textobject"
            },
            {
                "af",
                function()
                    require "nvim-treesitter-textobjects.select".select_textobject("@function.outer", "textobjects")
                end,
                mode = { "x", "o" },
                desc = "Select outer function textobject"
            },
            {
                "if",
                function()
                    require "nvim-treesitter-textobjects.select".select_textobject("@function.inner", "textobjects")
                end,
                mode = { "x", "o" },
                desc = "Select inner function textobject"
            },
            {
                "ac",
                function()
                    require "nvim-treesitter-textobjects.select".select_textobject("@class.outer", "textobjects")
                end,
                mode = { "x", "o" },
                desc = "Select outer class textobject"
            },
            {
                "ic",
                function()
                    require "nvim-treesitter-textobjects.select".select_textobject("@class.inner", "textobjects")
                end,
                mode = { "x", "o" },
                desc = "Select inner class textobject"
            },
            {
                "as",
                function()
                    require "nvim-treesitter-textobjects.select".select_textobject("@local.scope", "locals")
                end,
                mode = { "x", "o" },
                desc = "Select local scope textobject"
            },
        },
        init = function()
            -- Disable entire built-in ftplugin mappings to avoid conflicts.
            -- See https://github.com/neovim/neovim/tree/master/runtime/ftplugin for built-in ftplugins.
            -- vim.g.no_plugin_maps = true

            -- Or, disable per filetype (add as you like)
            vim.g.no_python_maps = true
            -- vim.g.no_ruby_maps = true
            -- vim.g.no_rust_maps = true
            -- vim.g.no_go_maps = true
        end,
        config = function()
            require("nvim-treesitter-textobjects").setup {
                select = {
                    -- Automatically jump forward to textobj, similar to targets.vim
                    lookahead = true,
                    include_surrounding_whitespace = false,
                },
            }
        end,
    }
}
