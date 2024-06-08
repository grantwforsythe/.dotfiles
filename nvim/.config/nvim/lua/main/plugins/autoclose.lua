return {{
    'm4xshen/autoclose.nvim',
    config = function()
        require('autoclose').setup({})
    end
},{
        'windwp/nvim-ts-autotag',
        config = function()
            require('nvim-ts-autotag').setup({})
        end
}}
