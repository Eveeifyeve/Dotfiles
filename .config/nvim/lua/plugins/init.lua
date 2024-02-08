



local plugins = {
    "nvim-lua/plenary.nvim",
    {
        ''
    },
    {
        "williamboman/mason.nvim",
        cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
        opts = function()
          return require "plugins.configs.mason"
        end,
        config = function(_, opts)
         require("mason").setup(opts)
          
    
      end,
      },
}




return plugins;


