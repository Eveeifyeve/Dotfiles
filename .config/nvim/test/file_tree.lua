return {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    config = function ()
        require("nvim-tree").setup()
    end
}