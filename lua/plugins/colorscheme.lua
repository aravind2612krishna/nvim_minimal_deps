return {
    {
        "oskarnurm/koda.nvim",
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            require("koda").setup({
                styles = {
                    comments = { italic = true },
                    -- keywords = { italic = true }
                }
            })
            vim.cmd("colorscheme koda")
        end,
    },
    {
        "wuelnerdotexe/vim-enfocado",
        enabled = false,
        lazy = false,
        priority = 1000,
        config = function(_, _)
            vim.o.termguicolors = true
            vim.o.background = "dark"
            vim.cmd.colorscheme "enfocado"
            vim.cmd [[hi! link MiniStatuslineFilename MoreMsg]]
            vim.cmd [[hi! link TabLineSel MoreMsg]]
            vim.cmd [[hi! link TabLine LspInlayHint]]
            vim.cmd [[hi! link TreesitterContextBottom Underlined]]
            vim.cmd [[hi! link VertSplit AccentSecond]]
        end

    },
    {
        "ellisonleao/gruvbox.nvim",
        enabled = false,
        lazy = false,
        priority = 1000,
        config = function()
            require("gruvbox").setup()
            vim.cmd.colorscheme("gruvbox")
        end,
    },
    {
        "EdenEast/nightfox.nvim",
        enabled = false,
        lazy = false,
        priority = 1000,
        config = function()
            require("nightfox").setup({
                options = {
                    -- Compiled file's destination location
                    compile_path = vim.fn.stdpath("cache") .. "/nightfox",
                    compile_file_suffix = "_compiled", -- Compiled file suffix
                    transparent = false, -- Disable setting background
                    terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
                    dim_inactive = true, -- Non focused panes set to alternative background
                    module_default = true, -- Default enable value for modules
                    colorblind = {
                        enable = false, -- Enable colorblind support
                        simulate_only = false, -- Only show simulated colorblind colors and not diff shifted
                        severity = {
                            protan = 0, -- Severity [0,1] for protan (red)
                            deutan = 0, -- Severity [0,1] for deutan (green)
                            tritan = 0, -- Severity [0,1] for tritan (blue)
                        },
                    },
                    styles = { -- Style to be applied to different syntax groups
                        comments = "italic", -- Value is any valid attr-list value `:help attr-list`
                        conditionals = "NONE",
                        constants = "NONE",
                        functions = "NONE",
                        keywords = "bold",
                        numbers = "NONE",
                        operators = "NONE",
                        strings = "NONE",
                        types = "NONE",
                        variables = "italic",
                    },
                    inverse = { -- Inverse highlight for different types
                        match_paren = false,
                        visual = false,
                        search = false,
                    },
                    modules = { -- List of various plugins and additional options
                        -- ...
                    },
                },
                palettes = {},
                specs = {},
                groups = {},
            })
            vim.cmd.colorscheme("nightfox")
        end,
    },
}
