-- Disable compatible mode, it's not using vi
vim.opt.compatible = false
vim.cmd('filetype off')  -- Change the way Neovim caches filetype rules at runtime

vim.opt.relativenumber = true  -- Relative line numbers
vim.opt.number = true  -- Absolute line numbers

vim.opt.expandtab = true  -- Use spaces instead of tabs
vim.opt.tabstop = 4  -- Tab width
vim.opt.shiftwidth = 4  -- Indentation width
vim.opt.softtabstop = 4  -- Insert spaces for tab
vim.opt.autoindent = true  -- Auto-indent new lines

vim.opt.wrap = false  -- Don't wrap text

vim.opt.swapfile = false  -- Disable swap files
vim.opt.backup = false  -- Disable backup files
vim.opt.undofile = true  -- Enable persistent undo
vim.opt.undodir = os.getenv('HOME') .. '/.vim/undo'

vim.opt.incsearch = true  -- Incremental search
vim.opt.hlsearch = false  -- Don't highlight search matches
vim.opt.ignorecase = true  -- Ignore case in search
vim.opt.smartcase = true  -- Smart case-sensitive search

vim.opt.termguicolors = true -- Enable more colors

-- Show at least 8 lines at the bottom while scrolling unless at the end of a file
vim.opt.scrolloff = 8
vim.opt.signcolumn = 'yes'

vim.opt.updatetime = 50

-- Set space as leader
vim.g.mapleader = ' '

vim.opt.errorbells = false

vim.opt.hidden = true  -- Allow hidden buffers

vim.opt.signcolumn = 'yes'  -- Always show the sign column

vim.opt.mouse = 'a'  -- Enable mouse support

-- Show spaces
vim.opt.list = true
vim.opt.listchars = {
    space = '.'
}

vim.opt.clipboard = 'unnamed'  -- Use system clipboard

-- Display current working directory in status line
vim.opt.laststatus = 2
vim.opt.statusline = '%!getcwd()'

vim.opt.colorcolumn = '120'  -- Highlight column 100
vim.cmd('highlight ColorColumn ctermbg=0 guibg=lightgrey')