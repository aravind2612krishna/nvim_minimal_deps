return {
  "harrisoncramer/gitlab.nvim",
  tag = "v3.3.11",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",
    "stevearc/dressing.nvim", -- Recommended but not required. Better UI for pickers.
    "nvim-tree/nvim-web-devicons", -- Recommended but not required. Icons in discussion tree.
  },

  build = function() require("gitlab.server").build(true) end, -- Builds the Go binary
  keys = {
    {
      "glc",
      function() require("gitlab").choose_merge_request() end,
      mode = "n",
      desc = "Choose review",
    },
    {
      "glS",
      function() require("gitlab").review() end,
      mode = "n",
      desc = "Open review",
    },
    {
      "glU",
      function() require("gitlab").choose_merge_request { reviewer_username = "aravk_altair" } end,
      mode = "n",
      desc = "Choose aravk_altair MRs",
    },
  },
  config = function(opts)
    require("gitlab").setup {
      debug = {
        go_request = true,
        go_response = true,
        gitlab_request = true, -- Requests to/from Gitlab
        gitlab_response = true,
      },
      log_path = vim.fn.stdpath "cache" .. "/gitlab.nvim.log", -- Log path for the Go server
      reviewer_settings = {
        diffview = {
          imply_local = true,
        },
      },
      discussion_sign_and_diagnostic = {
        skip_resolved_discussion = true,
        skip_old_revision_discussion = false,
      },
      discussion_tree = { -- The discussion tree that holds all comments
        position = "top", -- "top", "right", "bottom" or "left"
        tree_type = "by_file_name",
      },
    }
  end,
}
