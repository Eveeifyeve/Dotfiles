require("core.keymaps") 
require("core.settings")
require("core.commands")

-- -Init Lazy.nvim-
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- -Plugins Setup-
require("lazy").setup(require("plugins"))


-- if vim.g.neovide then vim.cmd[[cd $HOME]] require("notify")("Neovide is set to ~ directory") end

-- -Notification Section-


