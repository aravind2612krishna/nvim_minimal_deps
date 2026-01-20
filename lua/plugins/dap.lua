return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "williamboman/mason.nvim",
            {
                "jay-babu/mason-nvim-dap.nvim",
                config = function()
                    require("mason-nvim-dap").setup({
                        ensure_installed = { "python", "delve" },
                        handlers = {},
                    })
                end,
            },
        },
        lazy = true,
        -- Copied from LazyVim/lua/lazyvim/plugins/extras/dap/core.lua and
        -- modified.
        keys = {
            {
                "<F5>",
                function()
                    require("dap").continue()
                end,
                mode = "n",
                desc = "DapContinue",
            },
            {
                "<F10>",
                function()
                    require("dap").step_over()
                end,
                mode = "n",
                desc = "DapStepOver",
            },
            {
                "<F11>",
                function()
                    require("dap").step_into()
                end,
                mode = "n",
                desc = "DapStepInto",
            },
            {
                "<F12>",
                function()
                    require("dap").step_out()
                end,
                mode = "n",
                desc = "DapStepOutOf",
            },
            {
                "<Leader>dh",
                function()
                    require("dap.ui.widgets").hover()
                end,
                { "n", "v" },
                desc = "DapHover",
            },
            {
                "<Leader>dp",
                function()
                    require("dap.ui.widgets").preview()
                end,
                { "n", "v" },
                desc = "DapPreview",
            },
            {
                "<Leader>df",
                function()
                    local widgets = require("dap.ui.widgets")
                    widgets.centered_float(widgets.frames)
                end,
                mode = "n",
                desc = "DapFrames",
            },
            {
                "<leader>db",
                function()
                    require("dap").toggle_breakpoint()
                end,
                desc = "Toggle Breakpoint",
            },
            {
                "<leader>dB",
                function()
                    require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
                end,
                mode = "n",
                desc = "Debug toggle Conditional Breakpoint",
            },
            {
                "<leader>dc",
                function()
                    require("dap").continue()
                end,
                desc = "Continue",
            },

            {
                "<leader>dC",
                function()
                    require("dap").run_to_cursor()
                end,
                desc = "Run to Cursor",
            },

            {
                "<leader>dT",
                function()
                    require("dap").terminate()
                end,
                desc = "Terminate",
            },
        },
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
        config = function()
            require("dapui").setup()
            local dap, dapui = require("dap"), require("dapui")
            dap.listeners.before.attach.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                dapui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                dapui.close()
            end
        end,
        keys = {
            {
                "<leader>du",
                function()
                    require("dapui").toggle()
                end,
            },
        },
    },
}
