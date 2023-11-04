local opt = vim.opt

-- Make line numbers default
vim.wo.number = true

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
opt.clipboard = 'unnamedplus'

opt.completeopt = 'menuone,noinsert,noselect'

-- indet and wrap
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true
opt.breakindent = true
opt.wrap = false

-- search
opt.hlsearch = false

-- swapfile
opt.backup = false
opt.swapfile = false

-- numbers
opt.number = true
opt.relativenumber = true


