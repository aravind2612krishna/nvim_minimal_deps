return {
    -- lazy.nvim
    {
        "tanmaymanojgandhi/circadia",
        lazy = false,
        priority = 1000,
        enabled = false,
        init = function(plugin)
            local port_path = vim.fs.joinpath(plugin.dir, "ports", "neovim")
            local lua_path = vim.fs.joinpath(port_path, "lua", "?.lua")
            local lua_init = vim.fs.joinpath(port_path, "lua", "?", "init.lua")

            -- Register Lua paths
            package.path = package.path .. ";" .. lua_path .. ";" .. lua_init

            -- Directory to expose colorschemes to Neovim's picker
            local colors_dir = vim.fs.joinpath(vim.fn.stdpath("data"), "circadia_colors", "colors")
            vim.fn.mkdir(colors_dir, "p")

            local variants = {
                ["circadia-dark"] = [[
          vim.o.background = "dark"
          require("circadia").setup()
        ]],
                ["circadia-light"] = [[
          vim.o.background = "light"
          require("circadia").setup( { mode = "light"})
        ]],
            }

            for name, code in pairs(variants) do
                local file = vim.fs.joinpath(colors_dir, name .. ".lua")
                local f = io.open(file, "w")
                if f then
                    f:write(code)
                    f:close()
                end
            end

            -- Add directory to runtime path
            vim.opt.rtp:prepend(vim.fs.joinpath(vim.fn.stdpath("data"), "circadia_colors"))
        end,
        config = function()
            vim.opt.rtp:prepend(vim.fn.stdpath("data") .. "/lazy/circadia/ports/neovim")

            vim.o.background = "light"
            require("circadia").setup({ mode = "light" })
            vim.cmd("colorscheme circadia-light")
        end,
    },
    {
      'kungfusheep/mfd.nvim',
      lazy = false,
      priority = 1000,
      enabled = false,
      config = function()
        -- vim.o.background = "light"
        vim.cmd("colorscheme mfd")
        vim.cmd [[hi! link @lsp.type.property SpecialComment]]
        local function darken(hex, amount) -- amount: 0.0..1.0
            local r = tonumber(hex:sub(2, 3), 16)
            local g = tonumber(hex:sub(4, 5), 16)
            local b = tonumber(hex:sub(6, 7), 16)
            r = math.floor(r * (1 - amount))
            g = math.floor(g * (1 - amount))
            b = math.floor(b * (1 - amount))
            return string.format("#%02x%02x%02x", r, g, b)
        end

        local sc = vim.api.nvim_get_hl(0, { name = "SpecialComment", link = false })
        local fg = sc.fg and string.format("#%06x", sc.fg) or "#808080" -- fallback

        vim.api.nvim_set_hl(0, "specialcommentbolddark", {
            link = "specialcomment",
            fg = darken(fg, 0.9), -- 60% darker
            bold = true,
        })
      end,
    },
    {
        "oskarnurm/koda.nvim",
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        enabled = false,
        config = function()
            require("koda").setup({
                styles = {
                    comments = { italic = true },
                    -- keywords = { standout = true }
                }
            })
            vim.cmd("colorscheme koda")

            vim.api.nvim_set_hl(0, "@lsp.type.property", {
                link = "@lsp.type.property",
                italic = true,
            })
            -- vim.cmd [[hi! link @lsp.type.property @comment.todo]]
        end,
    },
    {
        "wuelnerdotexe/vim-enfocado",
        enabled = true,
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
