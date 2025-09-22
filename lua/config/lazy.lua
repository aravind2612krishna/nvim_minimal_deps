-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.spell = false
vim.opt.signcolumn = "yes"
vim.opt.wrap = false
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.cindent = true
vim.opt.completeopt = { "menu", "menuone", "noinsert", "popup" }
vim.opt.clipboard = "unnamedplus"
vim.opt.diffopt = "context:99999"
vim.opt.autoread = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.lazyredraw = true
vim.opt.termguicolors = true
vim.opt.virtualedit:append({ "block", "onemore" })           -- allow moving cursor past end of the line
vim.opt.sidescroll = 2                                       -- side scrolling
vim.opt.smartindent = true                                   -- auto indent after {, etc
vim.opt.fdo:append("jump")                                   -- open folds on jump
vim.opt.complete = { ".", "w" }                              -- auto complete from current buffer and open windows by default
vim.opt.sessionoptions = { "buffers", "curdir", "tabpages" } -- store these in mksession
vim.opt.clipboard = "unnamedplus"                            -- clipboard to vim yank
vim.opt.shortmess:append("c")
vim.opt.diffopt = { "context:99999", "filler", "algorithm:patience" }
vim.opt.list = true                                    -- Show whitespace characters
vim.opt.scrolloff = 4                                  -- 4 lines minimum above or below cursor
vim.opt.inccommand = "nosplit"                         -- Shows the effects of a command incrementally in the buffer
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir" -- Directory for undo files
vim.opt.undofile = true                                -- Enable persistent undo
if vim.fn.has("nvim-0.12") == 1 then
    vim.opt.winborder = "rounded"                          -- Use rounded borders for windows
end

-- vim.opt.foldnestmax = 1                                      -- only fold outer level
-- vim.opt.foldmethod = "indent"                                -- fold by indent by default
vim.o.foldmethod = 'expr'
vim.o.foldexpr = "v:lua.AravkMidMeshFold()"

G_foldnest = 0
function _G.AravkMidMeshFold()
    local lnum = vim.v.lnum
    if lnum == 0 then
        G_foldnest = 0
    end
    local line = vim.fn.getline(lnum)
    if line:match("^%s*$") then
      return "="
    end
    if line:match("^#if") then
        G_foldnest = G_foldnest + 1
        return "a1"
    end
    if line:match("^#endif") and G_foldnest > 0 then
        G_foldnest = G_foldnest - 1
        return "s1"
    end
    local indent = vim.fn.indent(lnum)
    if indent > 0 then
        indent = 1
    end
    local foldlevel = indent + G_foldnest
    return tostring(foldlevel)
end

vim.cmd.filetype("plugin indent on")                   -- Enable filetype detection, plugins, and indentation

local s = { silent = true }

vim.keymap.set("i", "jj", "<Esc>", { desc = "jj is easier to reach than Escape" })
vim.keymap.set("n", "<C-h>", "<C-W>h", { remap = true, desc = "Pane left" })
vim.keymap.set("n", "<C-j>", "<C-W>j", { remap = true, desc = "Pane down" })
vim.keymap.set("n", "<C-k>", "<C-W>k", { remap = true, desc = "Pane up" })
vim.keymap.set("n", "<leader>j", "<C-W>l", { remap = true, desc = "Pane right" })
vim.keymap.set("n", "<leader>h", "<C-W>h", { remap = true, desc = "Pane left" })
vim.keymap.set("n", "<leader>j", "<C-W>j", { remap = true, desc = "Pane down" })
vim.keymap.set("n", "<leader>k", "<C-W>k", { remap = true, desc = "Pane up" })
vim.keymap.set("n", "<leader>l", "<C-W>l", { remap = true, desc = "Pane right" })
vim.keymap.set("n", "<leader>[", "<cmd>tabprev<CR>", { remap = true, desc = "Tab previous" })
vim.keymap.set("n", "<leader>]", "<cmd>tabnext<CR>", { remap = true, desc = "Tab next" })
vim.keymap.set("n", "]e", function() vim.diagnostic.jump({count=1, wrap=false, severity=vim.diagnostic.severity.ERROR}) end, {remap = true, desc = "Next error"})
vim.keymap.set("n", "[e", function() vim.diagnostic.jump({count=-1, wrap=false, severity=vim.diagnostic.severity.ERROR}) end, {remap = true, desc = "Next error"})
vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, {remap = true, desc = "Go to definition"})
vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, {remap = true, desc = "Go to declaration"})

-- maps relative to current file
vim.keymap.set(
    "n",
    "<Leader>e",
    ':e <C-R>=expand("%:p:h") . "/" <CR>',
    { remap = true, desc = "Open :edit in dir of current file ...." }
)
vim.keymap.set(
    "n",
    "<Leader>t",
    ':tabe <C-R>=expand("%:p:h") . "/" <CR>',
    { remap = true, desc = "Open :tabnew in dir of current file" }
)

-- Quickfix
vim.keymap.set("n", "<C-q>", ":cclose<CR>", { remap = true, desc = "Close quickfix" })
vim.keymap.set("n", "<C-Q>", ":cclose<CR>", { remap = true, desc = "Close quickfix" })
vim.keymap.set("n", "<C-e>", function()
    local currwinid = vim.fn.win_getid()
    vim.cmd([[ topleft copen ]]) -- open quickfix top left
    vim.fn.win_gotoid(currwinid) -- go back to previous window
end, { remap = true, desc = "Open quickfix and jump to it" })

-- j and k over wrapped lines
vim.keymap.set("n", "j", function()
    return tonumber(vim.api.nvim_get_vvar("count")) > 0 and "j" or "gj"
end, { expr = true, silent = true }) -- Move down, but use 'gj' if no count is given
vim.keymap.set("n", "k", function()
    return tonumber(vim.api.nvim_get_vvar("count")) > 0 and "k" or "gk"
end, { expr = true, silent = true })           -- Move up, but use 'gk' if no count is given

vim.keymap.set("n", "<Leader>w", "<cmd>w!<CR>", s) -- Save the current file
vim.keymap.set("n", "<Leader>q", "<cmd>q<CR>", s)  -- Quit Neovim

local autooscgrp = vim.api.nvim_create_augroup("autoosc", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    pattern = "*",
    callback = function()
        vim.highlight.on_yank()
        if os.getenv("SSH_CONNECTION") then
            local copy_to_unnamedplus = require("vim.ui.clipboard.osc52").copy("+")
            copy_to_unnamedplus(vim.v.event.regcontents)
            local copy_to_unnamed = require("vim.ui.clipboard.osc52").copy("*")
            copy_to_unnamed(vim.v.event.regcontents)
        end
    end,
    group = autooscgrp,
})

-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        -- import your plugins
        { import = "plugins" },
    },
    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins.
    install = { colorscheme = { "habamax" } },
    -- automatically check for plugin updates
    checker = { enabled = false },
    defaults = {
        lazy = true,
    },
    change_detection = {
        enabled = false,
    },
})
