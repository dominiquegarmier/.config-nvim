local opt = vim.opt

-- Make line numbers default
vim.wo.number = true

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
opt.clipboard = "unnamedplus"

opt.completeopt = "menuone,noinsert,noselect"

-- indet and wrap
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true
opt.breakindent = true
opt.wrap = false

-- markdown word wrap
vim.api.nvim_create_autocmd("FileType", { pattern = { "markdown" }, command = "setlocal wrap" })

-- typst tabsize 2
vim.api.nvim_create_autocmd("FileType", { pattern = { "typst" }, command = "setlocal tabstop=2 shiftwidth=2 wrap" })

-- search
opt.hlsearch = false

-- swapfile
opt.backup = false
opt.swapfile = false

-- numbers
opt.number = true
opt.relativenumber = true
