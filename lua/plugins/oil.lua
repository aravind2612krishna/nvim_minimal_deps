return {
    {
        "A7Lavinraj/fyler.nvim",
        -- event = "VeryLazy",
        commands = "Fyler",
        keys = {
            { "<Leader>fe", "<cmd>Fyler kind=split_left_most<cr>", mode = { "n", "v" }, desc = "Fyler" },
        },
        dependencies = { "nvim-mini/mini.icons" },
        branch = "stable",
        opts = {
            default_explorer = false,
            close_on_select = false,
        },
        config = function (_, opts)
            require("fyler").setup(opts)
        end,
    },
    {
      "stevearc/oil.nvim",
      event = "VeryLazy",
      opts = {
        columns = {
          "icon",
          "permissions",
          "size",
          "mtime",
        },
        default_file_explorer = true,
      },
      -- Optional dependencies
      dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    -- {
    --   "Eutrius/Otree.nvim",
    --   enable = false,
    --   lazy = false,
    --   dependencies = {
    --     "nvim-tree/nvim-web-devicons",
    --     "stevearc/oil.nvim",
    --   },
    --   config = function()
    --     require("Otree").setup {
    --       hijack_netrw = false,
    --       show_hidden = true,
    --       show_ignore = true,
    --     }
    --   end,
    -- },
}
