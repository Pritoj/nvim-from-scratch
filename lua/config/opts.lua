local o = vim.o
local wo = vim.wo

-- Indenting
o.expandtab = true
o.shiftwidth = 2
o.smartindent = true
o.tabstop = 2
o.softtabstop = 2

o.relativenumber = true
o.number = true
wo.signcolumn = 'yes' -- Keep signcolumn on by default
