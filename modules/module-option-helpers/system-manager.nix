{
  inputs,
  config,
  lib,
  evalModulesModule,
  ...
}:
let
  cfg = config.systemManager;
in
{
  options.systemManager.configurations = lib.mkOption {
    type = lib.types.lazyAttrsOf (
      lib.types.submodule (
        { name, ... }:
        {
          imports = [
            evalModulesModule
            {
              fn = inputs.system-manager.lib.makeSystem;
              module = {
                networking.hostName = lib.mkDefault name;
              };
            }
          ];
        }
      )
    );
  };
  config = {
    flake.nixosConfigurations =
      cfg.configurations |> lib.mapAttrs (_name: { evaluation, ... }: evaluation);
    flake-file.inputs.system-manager = {
      url = "github:nixos-bsd/nixbsd";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-compat.follows = "flake-compat";
    };
  };
}
