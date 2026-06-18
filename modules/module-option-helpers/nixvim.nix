{
  inputs,
  lib,
  config,
  #evalModulesModule,
  #nixvim,
  ...
}:
# let
#   cfg = config.nixvim;
# in
{
  options = {
    users = lib.mkOption {
      type = lib.types.lazyAttrsOf (
        lib.types.submodule (_: {
          options = {
            nixvim = {
              base = lib.mkOption {
                type = lib.types.deferredModule;
              };
            };
          };

          config.nixvim = { inherit (config.nixvim.modules) base; };
        })
      );
    };

    nixvim = {
      modules = lib.mkOption {
        type = lib.types.lazyAttrsOf lib.types.deferredModule;
      };
    };
  };

  config =
    lib.genAttrs [ "nixos" "darwin" ] (_: {
      modules = {
        base = {
          home-manager.users =
            config.users
            |> lib.mapAttrs (
              _:
              { nixvim, ... }:
              {
                imports = [
                  inputs.nixvim.homeModules.nixvim
                  {
                    programs.nixvim = {
                      imports = [ nixvim.base ];
                      enable = true;
                      defaultEditor = true;
                      nixpkgs.useGlobalPackages = true;
                    };
                  }
                ];
              }
            );
        };
      };
    })
    // {
      flake-file.inputs.nixvim = {
        url = "github:nix-community/nixvim";
        inputs.nixpkgs.follows = "nixpkgs";
        inputs.systems.follows = "systems";
      };

      _module.args.nixvim = inputs.nixvim.lib.overlay |> lib.extend |> lib.getAttr "nixvim";

      # Ask @ Shahar how to fix this. BECAUSE I DON't KNOW.
      # perSystem = psArgs: {
      #   options.nixvim = lib.mkOption {
      #     type = lib.types.submodule {
      #       imports = [
      #         evalModulesModule
      #         {
      #           fn = nixvim.evalNixvim;
      #           args = { inherit (psArgs) system; };
      #           module = {
      #             imports = [ cfg.modules.base ];
      #             nixpkgs.pkgs = psArgs.pkgs;
      #           };
      #         }
      #       ];
      #     };
      #   };
      #
      #   config.packages.nixvim = psArgs.config.nixvim.evaluation.config.build.package;
      # };
    };
}
