-- Install lazy if it is not already installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)-- This file can be loaded by calling `lua require('plugins')` from your init.vim

require('lazy').setup({
    spec = 'main.plugins', -- Import all plugins
    ui = {
        border = 'rounded'
    }
})
