local s = { silent = true }

vim.g.mapleader = " " -- Space is my leader key
vim.keymap.set("i", "jj", "<Esc>", { desc = "jj is easier to reach than Escape" })
vim.keymap.set("n", "<C-h>", "<C-W>h", { remap = true, desc = "Pane left" })
vim.keymap.set("n", "<C-j>", "<C-W>j", { remap = true, desc = "Pane down" })
vim.keymap.set("n", "<C-k>", "<C-W>k", { remap = true, desc = "Pane up" })
vim.keymap.set("n", "<C-l>", "<C-W>l", { remap = true, desc = "Pane right" })

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
