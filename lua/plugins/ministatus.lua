return {
  "echasnovski/mini.statusline",
  version = false,
  event = "VeryLazy",
  specs = {
    {
      "rebelot/heirline.nvim",
      optional = true,
      enabled = false,
      opts = function(_, opts) opts.statusline = nil end,
    },
  },
  config = function(_, _) require("mini.statusline").setup() end,
}
