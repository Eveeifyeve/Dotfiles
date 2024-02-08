return {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    dependencies = {"nvim-tree/nvim-web-devicons"},
    config = function ()
        require("mason").setup()
        require("mason-lspconfig").setup()

        require('mason').setup({
            icons = {
                default = '',
                symlink = '',
                git = {
                    unstaged = '✗',
                    staged = '✓',
                    unmerged = '',
                    renamed = '➜',
                    deleted = '',
                    untracked = '★',
                    ignored = '◌'
                },
                folder = {
                    arrow_open = '',
                    arrow_closed = '',
                    default = '',
                    open = '',
                    empty = '',
                    empty_open = '',
                    symlink = '',
                },
                lsp = {
                    hint = '',
                    info = '',
                    warning = '',
                    error = '',
                }
            }
        })

        require("mason-lspconfig").setup {
            ensure_installed = { "lua_ls", "rust_analyzer" },
        }
    end
}