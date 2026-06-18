{
  config,
  lib,
  evalModulesModule,
  inputs,
  ...
}:
let
  cfg = config.darwin;
in
{
  options.darwin = {
    modules = lib.mkOption {
      type = lib.types.lazyAttrsOf lib.types.deferredModule;
    };

    configurations = lib.mkOption {
      type = lib.types.lazyAttrsOf (
        lib.types.submodule (
          { name, ... }:
          {
            imports = [
              evalModulesModule
              {
                fn = inputs.nix-darwin.lib.darwinSystem;
                module = {
                  networking.hostName = lib.mkDefault name;
                  nix.nixPath = [ "nix-darwin=${inputs.nix-darwin}" ];
                };
              }
            ];
          }
        )
      );
    };
  };

  config = {
    flake-file.inputs.nix-darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # For Nixd
    nixos.modules.base = {
      nix.nixPath = [ "nix-darwin=${inputs.nix-darwin}" ];
    };

    flake = {
      darwinConfigurations = cfg.configurations |> lib.mapAttrs (_name: { evaluation, ... }: evaluation);
      checks =
        config.flake.darwinConfigurations
        |> lib.mapAttrsToList (
          name: darwin: {
            ${darwin.config.nixpkgs.hostPlatform.system} = {
              "configurations:darwin:${name}" = darwin.config.system.build.toplevel;
            };
          }
        )
        |> lib.mkMerge;
    };
  };
}
