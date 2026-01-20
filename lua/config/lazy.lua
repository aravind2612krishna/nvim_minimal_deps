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
vim.opt.splitright = true
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir" -- Directory for undo files
vim.opt.undofile = true                                -- Enable persistent undo
if vim.fn.has("nvim-0.12") == 1 then
    vim.opt.winborder = "rounded"                          -- Use rounded borders for windows
end

-- vim.opt.foldnestmax = 1       -- only fold outer level
-- vim.opt.foldmethod = "marker" -- fold by indent by default
vim.api.nvim_create_augroup("C_Folding", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    group = "C_Folding",
    pattern = { "cpp", "c", "h", "hpp", "py", "python", "sh" },
    callback = function()
        if not vim.wo.scrollbind then
            vim.opt_local.foldmethod = "expr"
            -- vim.opt_local.foldexpr = "v:lua.AravkCFold()"
            -- vim.opt_local.foldexpr = "v:lua.vim.lsp.foldexpr()"
            vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
            vim.opt_local.foldnestmax = 10
        end
    end,
})
vim.api.nvim_create_autocmd("FileType", {
    pattern = {"TelescopeResults", "TelescopePrompt", "TelescopePreview"},
    command = "setlocal nofoldenable"
})

G_foldHashIf = 0
G_foldIndent = 0

function _G.AravkCFold()
    local lnum = vim.v.lnum
    if lnum == 1 then
        G_foldHashIf = 0
        G_foldIndent = 0
    end
    local line = vim.fn.getline(lnum)
    local foldlevel = 0
    if not line:match("^%s*$") then
        if line:match("^#if") or line:match("^{") then
            G_foldHashIf = G_foldHashIf + 1
        elseif line:match("^#endif") or line:match("^}") and G_foldHashIf > 0 then
            G_foldHashIf = G_foldHashIf - 1
            foldlevel = 1
        end
    end
    foldlevel = foldlevel + G_foldIndent + G_foldHashIf
    -- local buf = vim.api.nvim_get_current_buf()
    -- vim.api.nvim_buf_set_extmark(buf, G_ns, lnum - 1, 0, {
    --     virt_text = { { tostring(G_foldHashIf) .. "," .. tostring(G_foldIndent), "Comment" } },
    --     virt_text_pos = "eol",
    -- })
    return tostring(foldlevel)
end

-- G_ns = vim.api.nvim_create_namespace("foldlevel_debug")
function _G.AravkMidMeshFold()
    local lnum = vim.v.lnum
    if lnum == 0 then
        G_foldHashIf = 0
        G_foldIndent = 0
    end
    local line = vim.fn.getline(lnum)
    local foldlevel = 0
    if not line:match("^%s*$") then
        if line:match("^#if") then
            G_foldHashIf = G_foldHashIf + 1
        elseif line:match("^#endif") and G_foldHashIf > 0 then
            G_foldHashIf = G_foldHashIf - 1
            foldlevel = 1
        elseif G_foldHashIf == 0 then
            local indent = vim.fn.indent(lnum)
            if indent > 0 then
                G_foldIndent = 1
            else
                G_foldIndent = 0
            end
        end
    end
    foldlevel = foldlevel + G_foldIndent + G_foldHashIf
    -- local buf = vim.api.nvim_get_current_buf()
    -- vim.api.nvim_buf_set_extmark(buf, G_ns, lnum - 1, 0, {
    --     virt_text = { { tostring(G_foldHashIf) .. "," .. tostring(G_foldIndent), "Comment" } },
    --     virt_text_pos = "eol",
    -- })
    return tostring(foldlevel)
end

vim.cmd.filetype("plugin indent on")                   -- Enable filetype detection, plugins, and indentation

local s = { silent = true }

vim.keymap.set("i", "jj", "<Esc>", { desc = "jj is easier to reach than Escape" })
vim.keymap.set("n", "<C-h>", "<C-W>h", { remap = true, desc = "Pane left" })
vim.keymap.set("n", "<C-j>", "<C-W>j", { remap = true, desc = "Pane down" })
vim.keymap.set("n", "<C-k>", "<C-W>k", { remap = true, desc = "Pane up" })
vim.keymap.set({"n"}, "<leader>h", "<C-W>h", { remap = true, desc = "Pane left" })
vim.keymap.set({"n"}, "<leader>j", "<C-W>j", { remap = true, desc = "Pane down" })
vim.keymap.set({"n"}, "<leader>k", "<C-W>k", { remap = true, desc = "Pane up" })
vim.keymap.set({"n"}, "<leader>l", "<C-W>l", { remap = true, desc = "Pane right" })
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
vim.keymap.set(
    "n",
    "<Leader>rr",
    function()
        local rgcmd = "rg --vimgrep -i " .. vim.fn.expand("<cword>") .. " " .. vim.fn.expand("%:p:h")
        -- vim.cmd("cexpr(system(\"" .. rgcmd .. "\"))")
        vim.fn.feedkeys(":" .. "cexpr(system('" .. rgcmd .. "'))", "n")
    end,
    { remap = true, desc = "Grep word under cursor in current file's dir and open quickfix" }
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

if vim.g.neovide then
    vim.g.neovide_increment_scale_factor = vim.g.neovide_increment_scale_factor or 0.1
    vim.g.neovide_min_scale_factor = vim.g.neovide_min_scale_factor or 0.7
    vim.g.neovide_max_scale_factor = vim.g.neovide_max_scale_factor or 2.0
    vim.g.neovide_initial_scale_factor = vim.g.neovide_scale_factor or 1
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor or 1
    vim.g.neovide_fullscreen = true
    vim.g.neovide_remember_window_size = false
    vim.o.guifont = "JetBrainsMono Nerd Font Mono:h12"

    -- Scale factor
    local change_scale_factor = function(delta)
        vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
    end
    vim.keymap.set("n", "<C-=>", function()
        change_scale_factor(1.05)
    end)
    vim.keymap.set("n", "<C-->", function()
        change_scale_factor(1 / 1.05)
    end)

    -- Helper function for transparency formatting
    local alpha = function()
        return string.format("%x", math.floor(255 * vim.g.neovide_opacity_point or 0.8))
    end
    -- Set transparency and background color (title bar color)
    vim.g.neovide_opacity = 1.0
    vim.g.neovide_opacity_point = 0.8
    vim.g.neovide_background_color = "#0f1117" .. alpha()
    -- Add keybinds to change transparency
    local change_transparency = function(delta)
        vim.g.neovide_opacity_point = vim.g.neovide_opacity_point + delta
        vim.g.neovide_background_color = "#0f1117" .. alpha()
    end
    vim.keymap.set({ "n", "v", "o" }, "<M-]>", function()
        change_transparency(0.01)
    end)
    vim.keymap.set({ "n", "v", "o" }, "<M-[>", function()
        change_transparency(-0.01)
    end)

    vim.g.neovide_floating_corner_radius = 0.5

    vim.g.neovide_floating_blur_amount_x = 2.0
    vim.g.neovide_floating_blur_amount_y = 2.0

    vim.g.neovide_floating_shadow = true
    vim.g.neovide_floating_z_height = 10
    vim.g.neovide_light_angle_degrees = 45
    vim.g.neovide_light_radius = 5
end
