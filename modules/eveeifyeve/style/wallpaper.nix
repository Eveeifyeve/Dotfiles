{ inputs, ... }:
{
  flake-file.inputs.catppuccin-wallpapers = {
    url = "github:zhichaoh/catppuccin-wallpapers";
    flake = false;
  };

  home.gui = {
    stylix = {
      image = "${inputs.catppuccin-wallpapers}/catppuccin/mocha/kurzgesagt/Cloudy_Quasar_1-Catppuccin_Mocha.png";
    };
  };
}
