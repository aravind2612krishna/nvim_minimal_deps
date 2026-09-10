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
                        handlers = {
                            python = function (config)
                                config.adapters = {
                                    type = 'executable',
                                    command = '/work/repos/third_party/python/python3.10.18/linux64/bin/python3',
                                    args = { '-m', 'debugpy.adapter' },
                                }
                                require('mason-nvim-dap').default_setup(config)
                            end,
                        },
                    })
                end,
            },
        },
        lazy = true,
        config = function()
            local dap = require("dap")

            -- GDB 14+ includes a Debug Adapter Protocol implementation.
            dap.adapters.cpp = {
                type = "executable",
                command = "gdb",
                args = { "-i", "dap" },
            }

            local function most_recent_process()
                local query = vim.fn.input("Process name: ", "hwx")
                if query == "" then
                    return nil
                end

                local processes = vim.fn.systemlist({ "ps", "-eo", "pid=,args=", "--sort=-start_time" })
                for _, process in ipairs(processes) do
                    local pid, command = process:match("^%s*(%d+)%s+(.+)$")
                    if pid and command:find(query, 1, true) then
                        return tonumber(pid)
                    end
                end

                vim.notify(("No running process matches %q"):format(query), vim.log.levels.ERROR)
                return nil
            end

            dap.configurations.cpp = {
                {
                    name = "Launch executable",
                    type = "cpp",
                    request = "launch",
                    program = function()
                        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                    end,
                    cwd = "${workspaceFolder}",
                    stopAtBeginningOfMainSubprogram = true,
                },
                {
                    name = "Attach to most recent process",
                    type = "cpp",
                    request = "attach",
                    pid = most_recent_process,
                },
            }
        end,
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
    {
        "igorlfs/nvim-dap-view",
        enabled = false,
        version = vim.version.range("1.*"),
        cmd = "DapViewOpen",
        config = true,
    },
}
