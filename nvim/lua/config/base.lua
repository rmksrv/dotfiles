local opt = vim.opt
local g = vim.g

g.mapleader = " "
g.maplocalleader = " "

opt.number = true
opt.relativenumber = false
opt.mouse = "a"
opt.ignorecase = true
opt.smartcase = true
opt.termguicolors = true
opt.updatetime = 200
opt.signcolumn = "yes"
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.cursorline = true
opt.splitright = true
opt.splitbelow = true
opt.clipboard = "unnamedplus"

-- LSP messages
vim.diagnostic.enable = true
vim.diagnostic.config({
  virtual_lines = true,
})

-- Python indentation
-- https://github.com/aikow/dotfiles/blob/main/config/nvim/after/ftplugin/python.lua
vim.bo.expandtab = true
vim.bo.autoindent = true
vim.bo.shiftwidth = 4
vim.bo.tabstop = 4
vim.bo.softtabstop = 4
vim.bo.textwidth = 80
vim.g.pyindent_open_paren = vim.bo.shiftwidth
