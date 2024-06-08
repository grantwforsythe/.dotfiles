return {{
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    lazy = true,
    config = false,
    init = function()
        -- Disable automatic setup
        vim.g.lsp_zero_extend_cmp = 0
        vim.g.lsp_zero_extend_lspconfig = 0
    end
}, {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {'L3MON4D3/LuaSnip'},
    config = function()
        local lsp_zero = require('lsp-zero')
        lsp_zero.extend_cmp()

        -- auto completion
        local cmp = require('cmp')
        local cmp_action = lsp_zero.cmp_action()
        local cmp_select = {
            behavior = cmp.SelectBehavior.Select
        }

        cmp.setup({
            -- Preselect first option
            preselect = 'item',
            completion = {
                completeopt = 'menu,menuone,noinsert'
            },
            formatting = lsp_zero.cmp_format({
                details = true
            }),
            mapping = cmp.mapping.preset.insert({
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                ['<C-d>'] = cmp.mapping.scroll_docs(4),
                ['<C-f>'] = cmp_action.luasnip_jump_forward(),
                ['<C-b>'] = cmp_action.luasnip_jump_backward(),
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-y>'] = cmp.mapping.confirm({ select = false }),
                ['<Tab>'] = cmp_action.luasnip_supertab(),
                ['<S-Tab>'] = cmp_action.luasnip_shift_supertab()
            }),
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end
            }
        })
    end
}, {
    -- LSP
    'neovim/nvim-lspconfig',
    cmd = 'LspInfo',
    event = {'BufReadPre', 'BufNewFile'},
    dependencies = {'hrsh7th/cmp-nvim-lsp', 'williamboman/mason.nvim', 'williamboman/mason-lspconfig.nvim'},
    config = function()
        local lsp_zero = require('lsp-zero')
        lsp_zero.extend_lspconfig()

        lsp_zero.on_attach(function(client, bufnr)
            -- see :help lsp-zero-keybindings
            -- to learn the available actions
            lsp_zero.default_keymaps({
                buffer = bufnr
            })
            local opts = {
                buffer = bufnr,
                remap = false
            }

            vim.keymap.set('n', 'gd', function()
                vim.lsp.buf.definition()
            end, opts)
            vim.keymap.set('n', 'K', function()
                vim.lsp.buf.hover()
            end, opts)
            vim.keymap.set('n', '<leader>vws', function()
                vim.lsp.buf.workspace_symbol()
            end, opts)
            vim.keymap.set('n', '<leader>vd', function()
                vim.diagnostic.open_float()
            end, opts)
            vim.keymap.set('n', '[d', function()
                vim.diagnostic.goto_next()
            end, opts)
            vim.keymap.set('n', ']d', function()
                vim.diagnostic.goto_prev()
            end, opts)
            vim.keymap.set('n', '<leader>vca', function()
                vim.lsp.buf.code_action()
            end, opts)
            vim.keymap.set('n', '<leader>vrr', function()
                vim.lsp.buf.references()
            end, opts)
            vim.keymap.set('n', '<leader>vrn', function()
                vim.lsp.buf.rename()
            end, opts)
            vim.keymap.set('i', '<C-h>', function()
                vim.lsp.buf.signature_help()
            end, opts)
        end)

        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {'tsserver', 'eslint', 'angularls', 'emmet_ls'},
            handlers = {
                -- this first function is the "default handler"
                -- it applies to every language server without a "custom handler"
                function(server_name)
                    require('lspconfig')[server_name].setup({})
                end,
                -- this is the "custom handler" for 'lua_ls'
                lua_ls = function()
                    local lua_opts = lsp_zero.nvim_lua_ls()
                    require('lspconfig').lua_ls.setup(lua_opts)
                end,
                emmet_ls = function()
                    local capabilities = vim.lsp.protocol.make_client_capabilities()
                    capabilities.textDocument.completion.completionItem.snippetSupport = true

                    require('lspconfig').emmet_ls.setup({
                        capabilities = capabilities,
                        filetypes = {"css", "html", "javascriptreact", "less", "sass", "scss", "typescriptreact"},
                        init_options = {
                            html = {
                                options = {
                                    -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
                                    ["bem.enabled"] = true
                                }
                            }
                        }

                    })
                end
            }
        })
    end
}}
