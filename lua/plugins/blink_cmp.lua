MEnabled = {
  { "hrsh7th/nvim-cmp", enabled = false },
  {
    "saghen/blink.cmp",
    event = "InsertEnter",
    lazy = false, -- lazy loading handled internally
    -- optional: provides snippets for the snippet source
    dependencies = "rafamadriz/friendly-snippets",

    -- use a release tag to download pre-built binaries
    version = "v1.*",
    -- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    build = "cargo build --release",
    -- On musl libc based systems you need to add this flag
    -- build = 'RUSTFLAGS="-C target-feature=-crt-static" cargo build --release',

    opts = {
      -- use an empty table to disable a keymap
      -- keymap = "default",
      keymap = {
        preset = "default",
        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-e>"] = { "hide", "fallback" },
        ["<CR>"] = {
          function(cmp)
            if cmp.get_selected_item_idx then return cmp.accept() end
          end,
          "fallback",
        },

        ["<Tab>"] = {
          function(cmp)
            if (not cmp.is_visible()) and cmp.snippet_active() then
              return cmp.snippet_forward()
            else
              if cmp.is_visible() then return cmp.select_next() end
            end
          end,
          "fallback",
        },
        ["<S-Tab>"] = {
          function(cmp)
            if (not cmp.is_visible()) and cmp.snippet_active() then
              return cmp.snippet_backward()
            else
              if cmp.is_visible() then return cmp.select_prev() end
            end
          end,
          "fallback",
        },
      },
      fuzzy = {
        sorts = { "score", "sort_text", "exact" },
        use_frecency = true,
        use_proximity = true,
        implementation = "rust",
      },
      completion = {
        list = {
          selection = {
            preselect = true,
            -- preselect = function(ctx)
            --   return ctx.mode ~= "cmdline" and not require("blink.cmp").snippet_active { direction = 1 }
            -- end,
          },
        },
        ghost_text = {
          enabled = true,
          -- Show the ghost text when an item has been selected
          -- show_with_selection = true,
          -- Show the ghost text when no item has been selected, defaulting to the first item
          -- show_without_selection = false,
          -- Show the ghost text when the menu is open
          show_with_menu = false,
          -- Show the ghost text when the menu is closed
          show_without_menu = true,
        },
      },
      cmdline = {
        enabled = false,
        keymap = { preset = "inherit" },
        completion = {
          menu = { auto_show = true },
          list = {
            selection = {
              preselect = false,
              auto_insert = true,
            },
          },
        },
      },
      sources = {
        default = { "lsp", "buffer", "path", "snippets" },
        providers = {
          lsp = {
            min_keyword_length = 0,
            score_offset = 3,
            async = true,
            fallbacks = { "buffer", "snippets" },
          },
          snippets = { score_offset = -3 },
        },
      },
      -- signature = {
      --   enabled = true,
      -- },

      -- experimental auto-brackets support
      -- accept = { auto_brackets = { enabled = true } }

      -- experimental signature help support
      -- trigger = { signature_help = { enabled = true } }
      snippets = {
        score_offset = -10,
      },
    },
  },
  -- {
  --   "AstroNvim/astrolsp",
  --   dependencies = { "saghen/blink.cmp" },
  --   config = {
  --     clangd = {
  --       capabilities = require('blink.cmp').get_lsp_capabilities(require"astrolsp".config.clangd.capabilities)
  --     },
  --   },
  -- },
}

MDisabled = {
  {
    "saghen/blink.cmp",
    lazy = false, -- lazy loading handled internally
    enabled = false,
  },
}
return MEnabled
