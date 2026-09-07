return {
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        branch = "main",
        dependencies = {
            { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
            { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
        },
        opts = {
            -- See Configuration section for rest
        },
        cmd = { "CopilotChat" },
        -- See Commands section for default commands if you want to lazy load on them
    },
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        enabled = false,
        opts = {
            panel = {
                enabled = false,
                auto_refresh = false,
                keymap = {
                    jump_prev = "[[",
                    jump_next = "]]",
                    -- accept = "<M-CR>",
                    refresh = "gr",
                    open = "<C-CR>",
                },
                layout = {
                    position = "bottom", -- | top | left | right
                    ratio = 0.4,
                },
            },
            suggestion = {
                enabled = true,
                auto_trigger = true,
                hide_during_completion = false,
                debounce = 75,
                keymap = {
                    accept = "<M-CR>",
                    accept_word = false,
                    accept_line = false,
                    next = "<M-]>",
                    prev = "<M-[>",
                    dismiss = "<C-]>",
                },
            },
        },
        config = function(_, opts) require("copilot").setup(opts) end,
    },
    {
        "ray-x/copilot-agent.nvim",
        build = ":CopilotAgentInstall",
        lazy = false,
        enabled = false,
        config = function()
            require("copilot_agent").setup({
                -- When auto_start=true the plugin launches the Go service and reads its
                -- port from stderr automatically. No manual base_url needed.
                -- base_url = "http://127.0.0.1:8088",  -- only for externally-started services
                -- client_name = "nvim-copilot",
                -- permission_mode = "approve-all",  -- "interactive" | "approve-all" | "autopilot" | "reject-all"
                auto_create_session = true,
                -- session = {
                --     working_directory = function() return vim.fn.getcwd() end,
                --     model = nil,    -- nil = Copilot picks a default
                --     agent = nil,    -- nil = "default"; or "coding", "gpt-4.1", a custom agent name
                --     streaming = true,
                --     enable_config_discovery = true,  -- respects .github/copilot-instructions.md etc.
                --     replay_permission_history = false,  -- false (default) skips permission replay on resume for faster session loads
                --     auto_resume = "prompt",  -- "prompt" (default) | "auto" — when multiple sessions exist
                -- },
                service = {
                    auto_start = true,
                    -- command = nil means auto: uses <plugin_root>/bin/copilot-agent if present,
                    -- otherwise falls back to { "go", "run", "." } (requires Go toolchain).
                    command = nil,
                    cwd = nil,        -- defaults to <plugin_root>/server
                    detach = true,    -- default: reuse one detached background service across Neovim instances
                    port_range = nil, -- e.g. "18000-19000" for fixed range
                    startup_timeout_ms = 15000,
                    startup_poll_interval_ms = 250,
                },
                -- chat = {
                --     title = "Copilot Chat",
                --     system_notify_timeout = 3000,    -- ms before auto-clearing transient notices
                --     render_markdown = true,          -- set false to disable render-markdown.nvim (faster on long playbacks)
                --     protect_markdown_buffer = true,  -- upstream Neovim Treesitter workaround for the prompt buffer; set false to disable
                --     diff_cmd = { 'delta' },          -- external diff viewer; false = builtin float
                --     diff_review = true,              -- offer vimdiff after agent modifies a git-tracked file; clean buffers auto-reload, conflicting modified buffers prompt before reload
                -- },
                -- prompt = {
                --     style = "cold",                  -- "cold" (default) = red-violet/violet/blue, "warm" = red/yellow/green
                -- },
                -- compose = {
                --     width = 0.4,                     -- left split width; fraction of chat width, or absolute columns
                --     min_width = 40,
                --     max_width = 100,
                --     promote_keymap = "<leader>cc",   -- set false to disable the prompt-buffer promotion mapping
                -- },
                -- statusline = {
                --     enabled = false,                 -- default: keep plugin-owned chat/input local statuslines disabled
                --     components = {                   -- default: all true
                --         mode = true,
                --         permission = true,
                --         busy = true,
                --         session = true,
                --         model = true,
                --         tool = true,
                --         intent = true,
                --         context = true,
                --         config = true,
                --         attachments = true,
                --         help = true,
                --     },
                -- },
                -- notify = true,  -- set false to silence all [copilot-agent] vim.notify calls
                -- file_log_level = "WARN",  -- TRACE | DEBUG | INFO | WARN | ERROR; TRACE logs raw host/session payloads, DEBUG logs plugin actions and HTTP details to stdpath("log") .. "/copilot_agent.log"
                -- file_log_batch = {
                --     enabled = true,            -- queue file-log writes and flush in batches
                --     flush_interval_ms = 2000,  -- flush pending log lines at least every 2 seconds
                --     max_entries = 20,          -- flush immediately when queue reaches this size
                -- },
            })
            -- Start the combined HTTP + LSP service.
            -- Called automatically by CopilotAgentChat / CopilotAgentAsk if auto_start = true.
            -- Call explicitly here to get LSP code actions available immediately:
            require("copilot_agent").start_lsp()
        end,
    },
    {
        "folke/sidekick.nvim",
        dependencies = {
            {
                "Cannon07/code-preview.nvim",
                config = function()
                    require("code-preview").setup({
                        diff = {
                            layout  = "inline",   -- unified GitHub-style diff (the strategic default)
                            layouts = { opencode = "tab" }, -- override the layout per agent, to taste
                        },
                        neo_tree = { reveal_root = "git" }, -- reveal from the git root instead of cwd
                    })
                end,
            },
        },
        opts = {
            -- add any options here
            cli = {
                mux = {
                    backend = "zellij",
                    enabled = true,
                },
            },
        },
        keys = {
            {
                "<c-,>",
                function()
                    -- if there is a next edit, jump to it, otherwise apply it if any
                    if not require("sidekick").nes_jump_or_apply() then
                        return "<c-,>" -- fallback to normal tab
                    end
                end,
                expr = true,
                desc = "Goto/Apply Next Edit Suggestion",
            },
            {
                "<c-.>",
                function() require("sidekick.cli").focus() end,
                desc = "Sidekick Focus",
                mode = { "n", "t", "i", "x" },
            },
            {
                "<leader>aa",
                function() require("sidekick.cli").toggle() end,
                desc = "Sidekick Toggle CLI",
            },
            {
                "<leader>as",
                function() require("sidekick.cli").select() end,
                -- Or to select only installed tools:
                -- require("sidekick.cli").select({ filter = { installed = true } })
                desc = "Select CLI",
            },
            {
                "<leader>ad",
                function() require("sidekick.cli").close() end,
                desc = "Detach a CLI Session",
            },
            {
                "<leader>at",
                function() require("sidekick.cli").send({ msg = "{this}" }) end,
                mode = { "x", "n" },
                desc = "Send This",
            },
            {
                "<leader>af",
                function() require("sidekick.cli").send({ msg = "{file}" }) end,
                desc = "Send File",
            },
            {
                "<leader>av",
                function() require("sidekick.cli").send({ msg = "{selection}" }) end,
                mode = { "x" },
                desc = "Send Visual Selection",
            },
            {
                "<leader>ap",
                function() require("sidekick.cli").prompt() end,
                mode = { "n", "x" },
                desc = "Sidekick Select Prompt",
            },
            -- Example of a keybinding to open Claude directly
            {
                "<leader>ac",
                function() require("sidekick.cli").toggle({ name = "claude", focus = true }) end,
                desc = "Sidekick Toggle Claude",
            },
        },
    },
    {
        "linw1995/nvim-mcp",
        event = "VeryLazy",
        build = "cargo install --path .",
        opts = {},
    },
    {
        "ploMP4/draven.nvim",
        cmd = { "Draven", "DravenToggle", "DravenStatus" },
        keys = {
            { "<leader>ro", "<cmd>Draven<cr>", desc = "[R]eview [O]pen" },
        },
        opts = {},
    }
}
