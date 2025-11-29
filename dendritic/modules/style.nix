{
  inputs,
  config,
  lib,
  ...
}:

let
  theme =
    { pkgs, ... }:
    {
      #NOTE: Add more themes you want to try
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
in
{
  flake-file.inputs.stylix.url = "github:nix-community/stylix";
  flake-file.inputs.stylix.inputs.nixpkgs.follows = "nixpkgs";

  #NOTE: Please do not import home-manager if your using home-manager imported from eg. nixos.
  flake.modules.nixos.stylix = {
    imports = [
      inputs.stylix.nixosModules.stylix
      inputs.self.modules.stylix
    ];
  };

  flake.modules.darwin.stylix = {
    imports = [
      inputs.stylix.nixosModules.stylix
      inputs.self.modules.stylix
    ];
  };

  flake.modules.stylix = {
    stylix =
      { pkgs, ... }:
      let

        #NOTE: declare your theme from theme here.
        inherit (theme.catppucin) cursor base16Scheme;
      in
      {
        enable = true;
        autoEnable = true;
        polarity = "dark";
        image = config.lib.stylix.pixel "base00";
        inherit base16Scheme;
        fonts = rec {
          monospace = {
            package = pkgs.nerd-fonts.jetbrains-mono;
            name = "JetBrainsMono Nerd Font";
          };

          serif = monospace;
          sansSerif = monospace;
          emoji = monospace;
        }
        // lib.optionalAttrs pkgs.stdenv.isLinux {
          inherit cursor;
        };
      };
  };
}
