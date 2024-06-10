return {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree",
    branch = "v3.x",
    keys = {
        { '<C-t>', '<cmd>Neotree toggle<cr>', desc = 'Toggle Neotree' },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "ryanoasis/vim-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function ()
        require('neo-tree').setup({
            filters = {
                dotfiles = true,
            },
            lazy = false,
            window = {
                position = 'right',
            },
            filesystem = {
                follow_current_file = {
                    enabled = true,
                },
                hijack_netrw_behavior = 'open_current'
            }
        })
    end
}
