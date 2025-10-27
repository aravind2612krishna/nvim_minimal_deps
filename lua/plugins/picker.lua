return {
    {
        "nvim-telescope/telescope.nvim",
        enabled = false,
        branch = "0.1.x",
        dependencies = { "nvim-lua/plenary.nvim" },
        cmd = "Telescope",
        keys = {
            {
                "<leader>ff",
                function() require("telescope.builtin").find_files() end,
                mode = "n",
                desc = "Pick files",
            },
            {
                "<leader>fb",
                function() require("telescope.builtin").buffers() end,
                mode = "n",
                desc = "Pick buffers",
            },
            {
                "<leader>fr",
                function() require("telescope.builtin").resume() end,
                mode = "n",
                desc = "Resume picker",
            },
            {
                "<leader>fk",
                function() require("telescope.builtin").keymaps() end,
                mode = "n",
                desc = "Pick keymaps",
            },
            {
                "<leader>fl",
                function() require("telescope.builtin").current_buffer_fuzzy_find() end,
                mode = "n",
                desc = "Find lines",
            },
            {
                "<leader>fs",
                function() require("telescope.builtin").lsp_dynamic_workspace_symbols() end,
                mode = "n",
                desc = "Pick lsp symbols",
            },
        },
    },
    {
        "ibhagwan/fzf-lua",
        -- enabled = false,
        -- optional for icon support
        dependencies = { "nvim-tree/nvim-web-devicons" },
        -- or if using mini.icons/mini.nvim
        -- dependencies = { "nvim-mini/mini.icons" },
        opts = {},
        keys = {
            {
                "<leader>fg",
                function()
                    require("fzf-lua").global()
                end,
                desc = "Fzf global"
            },
            {
                "<leader>fs",
                function()
                    require("fzf-lua").lsp_live_workspace_symbols()
                end,
                desc = "Fzf live workspace symbols"
            },
        }
    },
    {
        'dmtrKovalenko/fff.nvim',
        enabled = false,
        build = function()
            -- this will download prebuild binary or try to use existing rustup toolchain to build from source
            -- (if you are using lazy you can use gb for rebuilding a plugin if needed)
            require("fff.download").download_or_build_binary()
        end,
        -- if you are using nixos
        -- build = "nix run .#release",
        opts = {                     -- (optional)
            debug = {
                enabled = false,     -- we expect your collaboration at least during the beta
                show_scores = false, -- to help us optimize the scoring system, feel free to share your scores!
            },
            keymaps = {
                close = '<Esc>',
                select = '<CR>',
                select_split = '<C-s>',
                select_vsplit = '<C-v>',
                select_tab = '<C-t>',
                move_up = { '<Up>', '<C-k>' },
                move_down = { '<Down>', '<C-j>' },
                preview_scroll_up = '<C-u>',
                preview_scroll_down = '<C-d>',
                toggle_debug = '<F2>',
            },
            logging = {
                enabled = true,
                log_file = vim.fn.stdpath('log') .. '/fff.log',
                log_level = 'error',
            },
            preview = {
                enabled = false,
            },
        },
        -- No need to lazy-load with lazy.nvim.
        -- This plugin initializes itself lazily.
        lazy = false,
        keys = {
            {
                "ff", -- try it if you didn't it is a banger keybinding for a picker
                function() require('fff').find_files() end,
                desc = 'FFFind files',
            }
        }
    },
    {
        "echasnovski/mini.pick",
        enabled = false,
        version = false,
        -- event = "VeryLazy",
        opts = {},
        config = function(_, opts)
            local pick = require("mini.pick")
            pick.setup(opts)
        end,
        keys = {
            {
                "<leader>ff",
                function() require("mini.pick").builtin.files() end,
                mode = "n",
                desc = "Pick files",
            },
            {
                "<leader>fb",
                function() require("mini.pick").builtin.buffers() end,
                mode = "n",
                desc = "Pick buffers",
            },
            {
                "<leader>fr",
                function() require("mini.pick").resume() end,
                mode = "n",
                desc = "Resume picker",
            },
            {
                "<leader>fl",
                function() require("mini.pick").builtin.grep_live() end,
                mode = "n",
                desc = "Find lines",
            },
        },
    },
    {
        'nvim-mini/mini.extra',
        version = '*',
        enabled = false,
        -- event = "VeryLazy",
        config = function()
            require("mini.extra").setup()
        end,
        keys = {
            {
                "<leader>fs",
                function() require("mini.extra").pickers.lsp({ scope = "workspace_symbol" }) end,
                mode = "n",
                desc = "Pick lsp symbols",
            },
            {
                "<leader>fk",
                function() require("mini.extra").pickers.keymaps() end,
                mode = "n",
                desc = "Pick keymaps",
            },
        },
    },
}
