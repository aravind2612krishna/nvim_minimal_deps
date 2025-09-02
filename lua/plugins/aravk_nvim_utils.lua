return {
    {
        -- dir = "/home/aravk/sources/aravk_nvim_utils",
        "aravind2612krishna/aravk_nvim_utils",
        dependencies = {
            "linrongbin16/gitlinker.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        keys = {
            {
                "<Leader>td",
                function()
                    local termdebug = require "aravk_nvim_utils.termdebug"
                    if termdebug then termdebug.setupdbg() end
                end,
                mode = "n",
                desc = "Setup termdebug and start it",
            },
        },
        cmd = { "CopyContext" },
        config = function(_, opts)
            require("aravk_nvim_utils.smartcodecopy").setup(opts)
        end
  },
  -- {
  --     -- "aravind2612krishna/aravk_nvim_utils",
  --     dir = "/home/aravk/sources/aravk_nvim_utils/",
  --     config = function(_, opts)
  --         require("aravk_nvim_utils.currentwindowfocus").setup()
  --     end
  -- },
}
