return {
    {
        "A7Lavinraj/fyler.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-mini/mini.icons" },
        branch = "stable",
        opts = {
            default_explorer = false,
        }
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
