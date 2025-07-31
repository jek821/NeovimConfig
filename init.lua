-- Bootstrap lazy.nvim (Package/Plugin Manager)
local lazypath = vim.fn.stdpath("config") .. "/lazy/lazy.nvim"
vim.opt.rtp:prepend(lazypath)
-- disable macro recording on q
vim.keymap.set("n", "q", "<Nop>")

require("lazy").setup("plugins") -- Load plugin specs from lua/plugins/

-- Basic options
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.number = true
