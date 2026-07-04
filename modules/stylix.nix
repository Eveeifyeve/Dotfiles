{
  lib,
  inputs,
  stylix,
  ...
}:
{
  flake-file.inputs.stylix = {
    url = "github:nix-community/stylix/combined-pr-testing";
    inputs.nixpkgs.follows = "nixpkgs";
    inputs.flake-parts.follows = "flake-parts";
    inputs.systems.follows = "systems";
  };

  _module.args.stylix = inputs.stylix;

  nixos.modules.gui =
    nixosArgs:
    let
      defaults = nixosArgs.config.home-manager.users.eveeifyeve.stylix;
    in
    {
      imports = [ stylix.nixosModules.stylix ];

      stylix = lib.mkMerge [
        {
          enable = true;
          homeManagerIntegration.autoImport = false;
        }

        (lib.mkDefault {
          inherit (defaults)
            icons
            base16Scheme
            cursor
            polarity
            ;

          fonts = {
            inherit (defaults.fonts)
              sansSerif
              serif
              monospace
              emoji
              sizes
              ;
          };
        })
      ];
    };

  darwin.modules.gui =
    darwinArgs:
    let
      defaults = darwinArgs.config.home-manager.users.eveeifyeve.stylix;
    in
    {
      imports = [ stylix.darwinModules.stylix ];

      stylix = lib.mkMerge [
        {
          enable = true;
          homeManagerIntegration.autoImport = false;
        }

        (lib.mkDefault {
          inherit (defaults) base16Scheme polarity;

          fonts = {
            inherit (defaults.fonts)
              sansSerif
              serif
              monospace
              emoji
              sizes
              ;
          };
        })
      ];
    };

  homeManager.modules.gui = {
    imports = [ stylix.homeModules.stylix ];
    stylix.enable = true;
  };
}
