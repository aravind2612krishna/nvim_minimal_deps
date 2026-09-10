-- Separate configuration for nvim-treesitter-textobjects

---@type LazySpec
return {
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        lazy = false,
        opts = {
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
            swap = {
                enable = true,
                keymaps = {
                    ["<leader>a"] = { query = "@parameter.inner", desc = "swap next parameter" },
                    ["<leader>A"] = { query = "@parameter.outer", desc = "swap previous parameter" },
                },
            },
            move = {
                -- whether to set jumps in the jumplist
                set_jumps = true,
            },
        },
        config = function (_, opts)
            require("nvim-treesitter-textobjects").setup(opts)
            -- ]m/[m (function identifier) for c/cpp are set in
            -- ftplugin/c.lua and ftplugin/cpp.lua via utils/func_nav.lua,
            -- which avoids the function_declarator's parameter list.
            -- ]M/[M (function end) stay global here.
            vim.keymap.set({ "n", "x", "o" }, "]]", function()
                require("nvim-treesitter-textobjects.move").goto_next_start("@class.outer", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "]M", function()
                require("nvim-treesitter-textobjects.move").goto_next_end("@function.outer", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "][", function()
                require("nvim-treesitter-textobjects.move").goto_next_end("@class.outer", "textobjects")
            end)

            vim.keymap.set({ "n", "x", "o" }, "[[", function()
                require("nvim-treesitter-textobjects.move").goto_previous_start("@class.outer", "textobjects")
            end)

            vim.keymap.set({ "n", "x", "o" }, "[M", function()
                require("nvim-treesitter-textobjects.move").goto_previous_end("@function.outer", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "[]", function()
                require("nvim-treesitter-textobjects.move").goto_previous_end("@class.outer", "textobjects")
            end)
        end
    },
}
