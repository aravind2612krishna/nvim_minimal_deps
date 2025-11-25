return {
    {
        -- dir = "/home/aravk/sources/aravk_nvim_utils",
        "aravind2612krishna/aravk_nvim_utils",
        dependencies = {
            "linrongbin16/gitlinker.nvim",
            "nvim-treesitter/nvim-treesitter",
            "nvim-treesitter/nvim-treesitter-textobjects",
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
            {
                "<Leader>8",
                function()
                    local sis = require "aravk_nvim_utils.searchinscope"
                    sis.search_current_function_word()
                end,
                mode = "n",
                desc = "Search current word in current function scope",
            },
        },
        cmd = { "CopyContext" },
        config = function(_, opts)
            require("aravk_nvim_utils.smartcodecopy").setup(opts)
            require("aravk_nvim_utils.searchinscope").setup()
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
