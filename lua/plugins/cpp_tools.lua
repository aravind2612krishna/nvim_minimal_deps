return {
  {
    "Badhi/nvim-treesitter-cpp-tools",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    cmd = { "TSCppDefineClassFunc", "TSCppMakeConcreteClass", "TSCppRuleOf3", "TSCppRuleOf5" },
    -- Optional: Configuration
    opts = function()
      local options = {
        preview = {
          quit = "q", -- optional keymapping for quit preview
          accept = "<tab>", -- optional keymapping for accept preview
        },
        header_extension = "h", -- optional
        source_extension = "cpp", -- optional
        custom_define_class_function_commands = { -- optional
          TSCppImplWrite = {
            output_handle = require("nt-cpp-tools.output_handlers").get_add_to_cpp(),
          },
          --[[
                <your impl function custom command name> = {
                    output_handle = function (str, context) 
                        -- string contains the class implementation
                        -- do whatever you want to do with it
                    end
                }
                ]]
        },
      }
      return options
    end,
    -- End configuration
    config = true,
  },
  {
    "willtrojniak/flipp.nvim",
    version = "*",

    ---@module 'flipp'
    ---@type flipp.Opts
    opts = {
      register = "f", -- The register to save definitions to
      lsp_name = "clangd", -- The name of the lsp to use
      peek = false, -- Whether or not to open floating window to source file
      namespaces = false, -- Whether or not to include namespaces in generated defs
      win = function(curr_win) -- Window config for peeking
        local curr_height = vim.api.nvim_win_get_height(curr_win)
        local curr_width = vim.api.nvim_win_get_width(curr_win)

        ---@type vim.api.keyset.win_config
        return {
          relative = "win",
          row = math.ceil(curr_height / 4),
          col = 0,
          height = math.ceil(curr_height / 2),
          width = curr_width,
        }
      end,
    },
  },
}
