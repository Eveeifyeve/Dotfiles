vim.opt.number = true -- Show line numbers
vim.opt.relativenumber = true -- Relative line numbers



vim.cmd('syntax enable') -- Enable syntax highlighting


vim.opt.tabstop = 4 -- Number of spaces a tab counts for
vim.opt.shiftwidth = 4 -- Size of an indent
vim.opt.expandtab = true -- Use spaces instead of tabs


vim.opt.incsearch = true -- Shows the match while typing
vim.opt.hlsearch = true -- Highlights the matches\


vim.opt.undofile = true -- Save undos after file closes


vim.opt.autowrite = true -- Automatically save before commands like :next and :make
vim.opt.autowriteall = true -- Automatically save before :quit and :exit





-- Neovide settings
if vim.g.neovide then
    vim.g.neovide_transparency = 0.9
    vim.g.transparency = 0.9
    vim.g.neovide_floating_blur_amount_x = 2.0
    vim.g.neovide_floating_blur_amount_y = 2.0
    vim.g.neovide_confirm_quit = true
    vim.g.neovide_cursor_vfx_mode = "railgun"
end