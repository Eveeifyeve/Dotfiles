return {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "nvim-telescope/telescope-fzf-native.nvim",
q   "romgrk/barbar.nvim",
    "nvim-lualine/lualine.nvim",
    build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
    dependencies = {"nvim-lua/plenary.nvim", "lewis6991/gitsigns.nvim", "nvim-tree/nvim-web-devicons"},
    config = function() 
    -- Turns off autosetup for barbar
    vim.g.barbar_auto_setup = false
    -- Extensions 
    local extensions = [[
    fzf
    ]]

    -- Splits the extensions.
    local extensionLines = {}
    for line in extensions:gmatch("[^\r\n]+") do
      table.insert(extensionLines, line)
    end

    -- LuaLine Configure Line below.
    require("lualine").setup({
      options = {
        theme = "horizon"
      },
     })

    --- Configure extensions
    require("telescope").setup {
        pickers = {
          colorscheme = {
            enable_preview = true
          }
        },
        extensions = {
            fzf = {
              fuzzy = true,
              override_generic_sorter = true,
              override_file_sorter = true,
              case_mode = "smart_case"
            }
        }
      }

    end    
}
