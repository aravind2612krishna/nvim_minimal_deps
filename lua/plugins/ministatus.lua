return {
    {
        "sontungexpt/witch-line",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        lazy = false, -- Almost component is lazy load by default. So you can set lazy to false
        opts = {},
        config = function (_, opts)
            vim.opt.laststatus = 3
            require("witch-line").setup(opts)
        end
    },
    {
        'b0o/incline.nvim',
        event = "VeryLazy",
        config = function()
            local helpers = require 'incline.helpers'
            local devicons = require 'nvim-web-devicons'
            require('incline').setup({
                window = {
                    padding = 0,
                    margin = { horizontal = 0 },
                },
                hide = {
                    cursorline = true,
                },
                render = function(props)
                    local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':t')
                    if filename == '' then
                        filename = '[No Name]'
                    end
                    local ft_icon, ft_color = devicons.get_icon_color(filename)
                    local modified = vim.bo[props.buf].modified
                    return {
                        ft_icon and { ' ', ft_icon, ' ', guibg = ft_color, guifg = helpers.contrast_color(ft_color) } or
                        '',
                        ' ',
                        { filename, gui = modified and 'bold,italic' or 'bold' },
                        ' ',
                        guibg = '#44406e',
                    }
                end,
            }
            )
        end,
    },
    -- {
    --     "bluz71/nvim-linefly",
    --     lazy = false,
    --     -- priority = 500,
    --     config = function()
    --         vim.g.linefly_options = {
    --             separator_symbol = "⎪",
    --             progress_symbol = "↓",
    --             active_tab_symbol = "▪",
    --             git_branch_symbol = "",
    --             error_symbol = "E",
    --             warning_symbol = "W",
    --             information_symbol = "I",
    --             ellipsis_symbol = "…",
    --             exclude_patterns = {},
    --             tabline = false,
    --             winbar = false,
    --             with_file_icon = true,
    --             with_git_branch = true,
    --             with_git_status = true,
    --             with_diagnostic_status = true,
    --             with_session_status = false,
    --             with_attached_clients = true,
    --             with_lsp_status = false,
    --             with_macro_status = true,
    --             with_search_count = false,
    --             with_spell_status = false,
    --             with_indent_status = false,
    --         }
    --     end,
    -- },
}
