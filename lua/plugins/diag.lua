return {
    {
        "caliguIa/zendiagram.nvim",
        opts = {
            header = "Diagnostics", -- Float window title
            source = true,  -- Whether to display diagnostic source
            relative = "line", -- "line"|"win" - What the float window's position is relative to
            anchor = "SW",  -- "NE"|"SE"|"SW"|"NW" - When 'relative' is set to "win" this sets the position of the floating window
        },
        keys = {
            {
                "]d",
                function()
                    vim.diagnostic.jump({ count = 1 })
                    vim.schedule(function()
                        require("zendiagram").open()
                        -- or: vim.cmd.Zendiagram('open')
                        -- or: Zendiagram.open()
                        -- or: vim.diagnostic.open_float() if you have overridden the default function
                    end)
                end,
                mode = { "n", "x" },
                desc = "Zendiagram diags next error",

            },
            {
                "[d",
                function()
                    vim.diagnostic.jump({ count = -1 })
                    vim.schedule(function()
                        require("zendiagram").open()
                        -- or: vim.cmd.Zendiagram('open')
                        -- or: Zendiagram.open()
                        -- or: vim.diagnostic.open_float() if you have overridden the default function
                    end)
                end,
                mode = { "n", "x" },
                desc = "Zendiagram diags prev error",

            },
        },
        config = function(_, opts)
            require('zendiagram').setup(opts)

            vim.keymap.set({ "n", "x" }, "[d", function()
                vim.diagnostic.jump({ count = -1 })
                vim.schedule(function()
                    require("zendiagram").open()
                    -- or: vim.cmd.Zendiagram('open')
                    -- or: Zendiagram.open()
                    -- or: vim.diagnostic.open_float() if you have overridden the default function
                end)
            end, { desc = "Jump to prev diagnostic" })
        end,
    },
}
