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
                "<C-p>",
                function()
                    require("fzf-lua").global()
                end,
                desc = "Fzf global"
            },
            {
                "<leader>fzs",
                function()
                    require("fzf-lua").lsp_live_workspace_symbols()
                end,
                desc = "Fzf live workspace symbols"
            },
        }
    },
    {
        'dmtrKovalenko/fff.nvim',
        build = function()
            -- downloads a prebuilt binary or falls back to cargo build
            require("fff.download").download_or_build_binary()
        end,
        -- for nixos:
        -- build = "nix run .#release",
        opts = {
            debug = {
                enabled = true,
                show_scores = true,
            },
        },
        lazy = false, -- the plugin lazy-initialises itself
        keys = {
            { "<leader>ff", function() require('fff').find_files() end, desc = 'FFFind files' },
            { "<leader>fg", function() require('fff').live_grep() end,  desc = 'LiFFFe grep' },
            {
                "<leader>fz",
                function() require('fff').live_grep({ grep = { modes = { 'fuzzy', 'plain' } } }) end,
                desc = 'Live fffuzy grep',
            },
            {
                "<leader>fc",
                function() require('fff').live_grep({ query = vim.fn.expand("<cword>") }) end,
                desc = 'Search current word',
            },
        },
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
