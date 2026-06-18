{
  inputs,
  config,
  lib,
  evalModulesModule,
  ...
}:
let
  cfg = config.bsd;
in
{
  options.bsd.configurations = lib.mkOption {
    type = lib.types.lazyAttrsOf (
      lib.types.submodule (
        { name, ... }:
        {
          imports = [
            evalModulesModule
            {
              fn = inputs.nixbsd.lib.nixbsdSystem;
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
    flake-file.inputs.nixbsd = {
      url = "github:nixos-bsd/nixbsd";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-compat.follows = "flake-compat";
    };
    flake.nixosConfigurations =
      cfg.configurations |> lib.mapAttrs (_name: { evaluation, ... }: evaluation);
  };
}
