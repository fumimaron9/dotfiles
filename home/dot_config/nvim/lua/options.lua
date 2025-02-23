vim.o.encoding = "utf-8"
vim.o.number = true
vim.o.termguicolors = true
vim.o.clipboard = 'unnamedplus'

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.loaded_netrw = true
vim.g.loaded_netrwPlugin = true
vim.g.clipboard = {
  name = 'OSC 52',
  copy = {
    ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
    ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
  },
  paste = {
    ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
    ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
  },
}

