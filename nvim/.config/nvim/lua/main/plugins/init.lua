return { -- Best colorscheme ever
    {'ellisonleao/gruvbox.nvim', config = function()
        require('gruvbox').setup({
            contrast = 'hard',
            transparent_mode = true
        })
        vim.cmd('colorscheme gruvbox')
    end
    }
}
