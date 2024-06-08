local function codeium_status()
    return vim.fn['codeium#GetStatusString']()
end

return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        local custom_gruvbox = require('lualine.themes.gruvbox');
        -- Make statusline transparent
        custom_gruvbox.normal.c.bg = 'None';
        custom_gruvbox.insert.c.bg = 'None';
        custom_gruvbox.visual.c.bg = 'None';
        custom_gruvbox.replace.c.bg = 'None';

        require('lualine').setup({
            options = {
                theme = custom_gruvbox,
            },
            interactive_sections = {
                lualine_y = {
                    {'progress'},
                    { codeium_status, color = { gui = 'bold' } }
                },
            }
        })
    end
}
