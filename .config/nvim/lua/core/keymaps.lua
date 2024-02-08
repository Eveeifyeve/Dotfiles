local map = vim.api.nvim_set_keymap

vim.g.mapleader = " "

local opts = { noremap = true, silent = true }
local description = {desc= "Custom keymap"}

map("i", "jk", "<ESC>", {desc = "Exit insert mode with jk"})

map("n", "tr", "<Cmd>NvimTreeFocus<CR>", opts)
map("i", "C-s", "<Cmd>w", opts)

-- Barbar
map('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', opts)
map('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', opts)
map('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', opts)
map('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', opts)
map('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', opts)
map('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', opts)
map('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', opts)
map('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', opts)
map('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', opts)
map('n', '<A-0>', '<Cmd>BufferLast<CR>', opts)
-- Close tab.
map('n', '<A-c>', '<Cmd>BufferClose<CR>', opts)

























