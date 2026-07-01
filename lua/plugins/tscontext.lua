return {
    {
        "nvim-treesitter/nvim-treesitter-context",
        dependencies = "nvim-treesitter/nvim-treesitter",
        cmd = "TSContext",
        opts = {
            throttle = true,         -- Throttles plugin updates (may improve performance)
            max_lines = 4,           -- How many lines the window should span. Values <= 0 mean no limit.
            multiline_threshold = 1, -- Maximum number of lines to show for a single context
            trim_scope = "inner",    -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
            mode = "topline",        -- Line used to calculate context. Choices: 'cursor', 'topline'
            separator = nil,         -- "─",
            patterns = {             -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
                -- For all filetypes
                -- Note that setting an entry here replaces all other patterns for this entry.
                -- By setting the 'default' entry below, you can control which nodes you want to
                -- appear in the context window.
                default = {
                    "class",
                    "function",
                    "method",
                    "for",
                    "while",
                    "if",
                    "else",
                    "switch",
                    "case",
                    "interface",
                    "struct",
                    "enum",
                },
                -- Example for a specific filetype.
                -- If a pattern is missing, *open a PR* so everyone can benefit.
                --   rust = {
                --       'impl_item',
                --   },
            },
        },
        config = function(_, opts)
            require("treesitter-context").setup(opts)
            vim.cmd [[hi! link TreesitterContextBottom Underlined]]
        end,
    },
    {
        "andersevenrud/nvim_context_vt",
        ft = { "cpp", "lua", "python", "rust", "go", "java", "javascript", "typescript" },
        config = function()
            local context_vt = require('nvim_context_vt')
            local context_vt_utils = require('nvim_context_vt.utils')

            local function cursor_scope_validator(node, ft, opts)
                local default_validator = context_vt_utils.default_validator
                if not default_validator(node, ft, opts) then
                    return false
                end
                if node:type() == 'function' then
                    return false
                end

                local start_row = node:start() -- 0-indexed row
                local win_top_row = vim.fn.line("w0") - 1 -- convert to 0-indexed row
                return start_row < win_top_row
            end

            local function visible_window_validator(node, ft, opts)
                local default_validator = context_vt_utils.default_validator
                if not default_validator(node, ft, opts) then
                    return false
                end
                local start_row = node:start() -- 0-indexed row
                local win_top_row = vim.fn.line("w0") - 1 -- convert to 0-indexed row
                return start_row < win_top_row
            end

            local vt_opts = {
                -- Enable this to annotate all matching nodes whose scope starts in the visible window.
                visible_window_mode = true,

                -- Enable by default. You can disable and use :NvimContextVtToggle to maually enable.
                -- Default: true
                enabled = true,

                -- Override default virtual text prefix
                -- Default: '-->'
                prefix = '',

                -- Override default virtual text priority
                -- Default: 1000
                priority = 1000,

                -- Override the internal highlight group name
                -- Default: 'ContextVt'
                highlight = 'Comment',

                -- Disable virtual text for given filetypes
                -- Default: { 'markdown' }
                disable_ft = { 'markdown', 'tcl' },

                -- Disable display of virtual text below blocks for indentation based languages like Python
                -- Default: false
                disable_virtual_lines = false,

                -- Same as above but only for spesific filetypes
                -- Default: {}
                disable_virtual_lines_ft = {},

                -- How many lines required after starting position to show virtual text
                -- Default: 1 (equals two lines total)
                min_rows = 1,

                -- Same as above but only for spesific filetypes
                -- Default: {}
                min_rows_ft = {},

                -- Custom virtual text node parser callback
                -- Default: nil
                -- custom_parser = function(node, ft, opts)
                --     local utils = require('nvim_context_vt.utils')
                --
                --     -- If you return `nil`, no virtual text will be displayed.
                --     if node:type() == 'function' then
                --         return nil
                --     end
                --
                --     -- This is the standard text
                --     return opts.prefix .. ' ' .. utils.get_node_text(node)[1]
                -- end,

                -- Custom node validator callback
                -- Default: nil
                custom_validator = cursor_scope_validator,

                -- Custom node virtual text resolver callback
                -- Default: nil
                -- custom_resolver = function(nodes, ft, opts)
                --     -- By default the last node is used
                --     return nodes[#nodes]
                -- end,
            }

            local visible_window_mode = vt_opts.visible_window_mode
            vt_opts.enabled = not visible_window_mode
            if visible_window_mode then
                vt_opts.custom_validator = visible_window_validator
            end

            context_vt.setup(vt_opts)

            if not visible_window_mode then
                return
            end

            local visible_ns = vim.api.nvim_create_namespace('context_vt_visible_window')

            local function show_visible_window_context()
                local bufnr = vim.api.nvim_get_current_buf()
                local ft = context_vt.get_buf_lang(bufnr)
                if vim.tbl_contains(vt_opts.disable_ft, ft) then
                    vim.api.nvim_buf_clear_namespace(bufnr, visible_ns, 0, -1)
                    return
                end

                local ok, parser = pcall(vim.treesitter.get_parser, bufnr, ft)
                if not ok or not parser then
                    vim.api.nvim_buf_clear_namespace(bufnr, visible_ns, 0, -1)
                    return
                end

                local trees = parser:parse()
                local tree = trees and trees[1]
                if not tree then
                    vim.api.nvim_buf_clear_namespace(bufnr, visible_ns, 0, -1)
                    return
                end

                local root = tree:root()
                local top_row = vim.fn.line("w0") - 1
                local bottom_row = vim.fn.line("w$") - 1

                local validate = vt_opts.custom_validator or context_vt_utils.default_validator
                local resolve = vt_opts.custom_resolver or context_vt_utils.default_resolver
                local parse = vt_opts.custom_parser or context_vt_utils.default_parser
                local create_vt = context_vt_utils.create_virtual_text_factory(parse, ft, vt_opts)

                ---@type table<number, TSNode[]>
                local result = {}

                local stack = { root }
                while #stack > 0 do
                    local node = table.remove(stack)
                    local start_row = node:start()
                    local end_row = node:end_()

                    if end_row >= top_row and start_row <= bottom_row then
                        if validate(node, ft, vt_opts) then
                            local target_line = end_row

                            if target_line >= top_row and target_line <= bottom_row then
                                result[target_line] = result[target_line] or {}
                                table.insert(result[target_line], node)
                            end
                        end

                        for child in node:iter_children() do
                            table.insert(stack, child)
                        end
                    end
                end

                vim.api.nvim_buf_clear_namespace(bufnr, visible_ns, 0, -1)
                for line, nodes in pairs(result) do
                    local node = resolve(nodes, ft, vt_opts)
                    local vt = create_vt(node, nodes)
                    if vt then
                        vt.priority = vt_opts.priority
                        vim.api.nvim_buf_set_extmark(bufnr, visible_ns, line, 0, vt)
                    end
                end
            end

            local group = vim.api.nvim_create_augroup('NvimContextVtVisibleWindow', { clear = true })
            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI", "WinScrolled", "TextChanged", "TextChangedI" }, {
                group = group,
                callback = show_visible_window_context,
            })
        end
    }
}
