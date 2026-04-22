---@module "neominimap.config.meta"
return 
{
    {
        "lewis6991/satellite.nvim",
        cmd = { "SatelliteEnable" },
        opts = {
            current_only = false,
            winblend = 25,
            zindex = 100,
            excluded_filetypes = {},
            width = 3,
            handlers = {
                cursor = {
                    enable = true,
                    -- Supports any number of symbols
                    symbols = { '⎺', '⎻', '⎼', '⎽' }
                    -- symbols = { '⎻', '⎼' }
                    -- Highlights:
                    -- - SatelliteCursor (default links to NonText
                },
                search = {
                    enable = true,
                    -- Highlights:
                    -- - SatelliteSearch (default links to Search)
                    -- - SatelliteSearchCurrent (default links to SearchCurrent)
                },
                diagnostic = {
                    enable = true,
                    signs = { '', '⚠', '!' },
                    min_severity = vim.diagnostic.severity.ERROR,
                    -- Highlights:
                    -- - SatelliteDiagnosticError (default links to DiagnosticError)
                    -- - SatelliteDiagnosticWarn (default links to DiagnosticWarn)
                    -- - SatelliteDiagnosticInfo (default links to DiagnosticInfo)
                    -- - SatelliteDiagnosticHint (default links to DiagnosticHint)
                },
                gitsigns = {
                    enable = true,
                    signs = { -- can only be a single character (multibyte is okay)
                        add = "+",
                        change = "~",
                        delete = "-",
                    },
                    -- Highlights:
                    -- SatelliteGitSignsAdd (default links to GitSignsAdd)
                    -- SatelliteGitSignsChange (default links to GitSignsChange)
                    -- SatelliteGitSignsDelete (default links to GitSignsDelete)
                },
                marks = {
                    enable = true,
                    show_builtins = false, -- shows the builtin marks like [ ] < >
                    key = 'm'
                    -- Highlights:
                    -- SatelliteMark (default links to Normal)
                },
                quickfix = {
                    enable = false,
                    signs = { '.' },
                    -- Highlights:
                    -- SatelliteQuickfix (default links to WarningMsg)
                }
            },
        },
        config = function(_, opts)
            require("satellite").setup(opts)
        end,
    },
    {
  "Isrothy/neominimap.nvim",
  enabled=false,
  version = "v3.x.x",
  lazy = false, -- NOTE: NO NEED to Lazy load
  -- Optional. You can also set your own keybindings
  keys = {
    -- Global Minimap Controls
    { "<leader>nm", "<cmd>Neominimap Toggle<cr>", desc = "Toggle global minimap" },
    -- { "<leader>no", "<cmd>Neominimap Enable<cr>", desc = "Enable global minimap" },
    -- { "<leader>nc", "<cmd>Neominimap Disable<cr>", desc = "Disable global minimap" },
    { "<leader>nr", "<cmd>Neominimap Refresh<cr>", desc = "Refresh global minimap" },

    -- Window-Specific Minimap Controls
    { "<leader>nwt", "<cmd>Neominimap WinToggle<cr>", desc = "Toggle minimap for current window" },
    { "<leader>nwr", "<cmd>Neominimap WinRefresh<cr>", desc = "Refresh minimap for current window" },
    -- { "<leader>nwo", "<cmd>Neominimap WinEnable<cr>", desc = "Enable minimap for current window" },
    -- { "<leader>nwc", "<cmd>Neominimap WinDisable<cr>", desc = "Disable minimap for current window" },

    -- Tab-Specific Minimap Controls
    { "<leader>ntt", "<cmd>Neominimap TabToggle<cr>", desc = "Toggle minimap for current tab" },
    { "<leader>ntr", "<cmd>Neominimap TabRefresh<cr>", desc = "Refresh minimap for current tab" },
    -- { "<leader>nto", "<cmd>Neominimap TabEnable<cr>", desc = "Enable minimap for current tab" },
    -- { "<leader>ntc", "<cmd>Neominimap TabDisable<cr>", desc = "Disable minimap for current tab" },

    -- Buffer-Specific Minimap Controls
    { "<leader>nbt", "<cmd>Neominimap BufToggle<cr>", desc = "Toggle minimap for current buffer" },
    { "<leader>nbr", "<cmd>Neominimap BufRefresh<cr>", desc = "Refresh minimap for current buffer" },
    -- { "<leader>nbo", "<cmd>Neominimap BufEnable<cr>", desc = "Enable minimap for current buffer" },
    -- { "<leader>nbc", "<cmd>Neominimap BufDisable<cr>", desc = "Disable minimap for current buffer" },

    ---Focus Controls
    -- { "<leader>nf", "<cmd>Neominimap Focus<cr>", desc = "Focus on minimap" },
    -- { "<leader>nu", "<cmd>Neominimap Unfocus<cr>", desc = "Unfocus minimap" },
    { "<leader>ns", "<cmd>Neominimap ToggleFocus<cr>", desc = "Switch focus on minimap" },
  },
  init = function()
    -- The following options are recommended when layout == "float"
    vim.opt.wrap = false
    vim.opt.sidescrolloff = 36 -- Set a large value

    --- Put your configuration here
    ---@type Neominimap.UserConfig
    vim.g.neominimap = {
      auto_enable = true,
      mark = {
          enabled = true,
      },
      diagnostic = {
          severity = vim.diagnostic.severity.ERROR,
      },
      treesitter = {
          enabled = false,
      },
    }
  end,
},
}
