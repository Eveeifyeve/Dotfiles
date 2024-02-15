local wezterm = require 'wezterm'
local config = {}


local function scheme_for_appearance(appearance)
    if appearance:find "Dark" then
      return "Catppuccin Macchiato"
    else
      return "Catppuccin Latte"
    end
  end

config.enable_tab_bar = false
config.window_close_confirmation = 'NeverPrompt'
config.color_scheme = scheme_for_appearance(wezterm.gui.get_appearance())
config.hide_mouse_cursor_when_typing = false

return config