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
vim.opt.foldmethod = "marker"                                -- fold by markers by default
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
vim.opt.winborder = "rounded"                          -- Use rounded borders for windows

vim.cmd.filetype("plugin indent on")                   -- Enable filetype detection, plugins, and indentation
