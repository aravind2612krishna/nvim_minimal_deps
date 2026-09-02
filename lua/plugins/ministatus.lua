return {
    {
        "sontungexpt/witch-line",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        lazy = false, -- Almost component is lazy load by default. So you can set lazy to false
        opts = {
            statusline = {
                global = {
                    "mode",
                    {
                        [0] = "file.name",
                        padding = { left = 0, right = 1 },
                        left_style = { link = "Comment" },
                        left = function()
                            if vim.bo.buftype ~= "" then
                                return ""
                            end

                            local filepath = vim.api.nvim_buf_get_name(0)
                            if filepath == "" then
                                return ""
                            end

                            local relative = vim.fn.fnamemodify(filepath, ":~:.")
                            local dir = vim.fn.fnamemodify(relative, ":h")
                            if dir == "." then
                                return ""
                            end

                            return "%<" .. dir .. "/"
                        end,
                    },
                    "file.icon",
                    "file.modifier",
                    "git.branch",
                    "git.diff.added",
                    "git.diff.removed",
                    "git.diff.modified",
                    "%=",
                    "diagnostic.error",
                    "diagnostic.warn",
                    "diagnostic.info",
                    "diagnostic.hint",
                    "lsp.clients",
                    "windsurf.neocodeium",
                    "indent",
                    "cursor.pos",
                    "cursor.progress",
                },
            },
        },
        config = function (_, opts)
            vim.opt.laststatus = 2
            require("witch-line").setup(opts)
            vim.opt.statuscolumn = "%l%=%s │ "
        end
    },
    {
        'nvim-mini/mini.statuscolumn',
        event = "VeryLazy",
        version = false,
        config = true,
    },
    {
        'b0o/incline.nvim',
        enabled = false,
        -- event = "VeryLazy",
        config = function()
            local helpers = require 'incline.helpers'
            local devicons = require 'nvim-web-devicons'
            require('incline').setup({
                window = {
                    padding = 0,
                    margin = { 
                        horizontal = 0,
                        vertical = 1,
                    },
                    placement = {
                        vertical = "bottom",
                        horizontal = "left"
                    }
                },
                hide = {
                    cursorline = true,
                },
                render = function(props)
                    local filename = vim.api.nvim_buf_get_name(props.buf)
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
