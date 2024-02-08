return {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    config = function()
      local logo =
        [[
    _______   ___      ___ _______   _______   ___  ________ ___    ___ _______   ___      ___ _______
    |\  ___ \ |\  \    /  /|\  ___ \ |\  ___ \ |\  \|\  _____\\  \  /  /|\  ___ \ |\  \    /  /|\  ___ \
    \ \   __/|\ \  \  /  / | \   __/|\ \   __/|\ \  \ \  \__/\ \  \/  / | \   __/|\ \  \  /  / | \   __/|
     \ \  \_|/_\ \  \/  / / \ \  \_|/_\ \  \_|/_\ \  \ \   __\\ \    / / \ \  \_|/_\ \  \/  / / \ \  \_|/__
      \ \  \_|\ \ \    / /   \ \  \_|\ \ \  \_|\ \ \  \ \  \_| \/  /  /   \ \  \_|\ \ \    / /   \ \  \_|\ \
       \ \_______\ \__/ /     \ \_______\ \_______\ \__\ \__\__/  / /      \ \_______\ \__/ /     \ \_______\
        \|_______|\|__|/       \|_______|\|_______|\|__|\|__|\___/ /        \|_______|\|__|/       \|_______|
                                                            \|___|/
  
  
                                                               ___      ___ ___  _____ ______
                                                              |\  \    /  /|\  \|\   _ \  _   \
                                                              \ \  \  /  / | \  \ \  \\\__\ \  \
                                                               \ \  \/  / / \ \  \ \  \\|__| \  \
                                                                \ \    / /   \ \  \ \  \    \ \  \
                                                                 \ \__/ /     \ \__\ \__\    \ \__\
                                                                  \|__|/       \|__|\|__|     \|__|
  ]]
  
      local foot =
        [[
   ©️ 2023 Eveeifyeve.
   This project is licensed under the EPL2.0.
   Find more about the license by looking at the LICENSE file.
  
   --Versions--
  
   Vim version: ]] ..
        vim.version().major .. "." .. vim.version().minor .. "." .. vim.version().patch .. [[
  ]]
  
      logo = string.rep("\n", 8) .. logo .. "\n\n"
      foot = string.rep("\n", 8) .. foot .. "\n\n"
  
      require("dashboard").setup {
        theme = "doom",
        config = {
          header = vim.split(logo, "\n"),
          center = {
            {action = "cd $HOME | Telescope find_files prompt_prefix= ", desc = " Find file", icon = " ", key = "f"},
            {action = "ene | startinsert", desc = "New file", icon = "  ", key = "n"},
            {action = "Telescope oldfiles", desc = "Recent files", icon = "  ", key = "r"},
            {action = "cd ~ | Telescope live_grep", desc = "Find text", icon = "  ", key = "g"},
            {action = 'lua require("persistence").load()', desc = "Restore Session", icon = "  ", key = "s"},
            {action = "LspConig", desc = "Mason Extras", icon = "  ", key = "m"},
            {action = "Lazy", desc = "LazyNvim", icon = "󰒲  ", key = "l"},
            {action = 'cd ~/.config/nvim | Telescope find_files prompt_prefix=', desc = "Config", icon = "  ", key = "c"},
            {action = "qa", desc = "Quit", icon = "  ", key = "q"}
           },
          footer = vim.split(foot, "\n")
        }
      }
    end,
    dependencies = {{"nvim-tree/nvim-web-devicons"}}
  }
  