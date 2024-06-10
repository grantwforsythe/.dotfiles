require('main.set')
-- Need to call remap first as it sets leader before loading plugins
require('main.remap')
require('main.lazy_init')

vim.o.background = 'dark'
vim.cmd([[colorscheme gruvbox]])
