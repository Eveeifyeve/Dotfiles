{
  inputs,
  pkgs,
  self',
  config,
  ...
}:
{
  flake-file.inputs.stylix.url = "github:nix-community/stylix";
  flake-file.inputs.stylix.inputs.nixpkgs.follows = "nixpkgs";

  #NOTE: Please do not import home-manager if your using nixos or nix-darwin
  flake.modules.nixos.stylix = {
    stylix = self'.modules.stylix;
    imports = [
      inputs.stylix.nixosModules.stylix
    ];
  };

  flake.modules.darwin.stylix = {
    stylix = self'.modules.stylix;
    imports = [
      inputs.stylix.nixosModules.stylix
    ];
  };

  flake.modules.stylix = {
    enable = true;
    autoEnable = true;
    polarity = "dark";
    image = config.lib.stylix.pixel "base00";
    inherit (self'.lib.theme.catppucin) base16Scheme;
    fonts = rec {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
      };

      serif = monospace;
      sansSerif = monospace;
      emoji = monospace;
    };
  };

  lib.themes = {
    catppucin = {
      base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
      cursor = {
        name = "Catppuccin-Mocha-Blue";
        package = pkgs.catppuccin-cursors.mochaBlue;
      };
    };
    rose-pine = {
      base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";
      cursor = {
        name = "BreezeX-RosePine-Linux";
        package = pkgs.rose-pine-cursor;
      };
    };
  };
}
