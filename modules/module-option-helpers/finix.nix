{
  inputs,
  config,
  lib,
  evalModulesModule,
  ...
}:
let
  cfg = config.finix;
in
{
  options.finix.configurations = lib.mkOption {
    type = lib.types.lazyAttrsOf (
      lib.types.submodule (
        { name, ... }:
        {
          imports = [
            evalModulesModule
            {
              fn = inputs.finix.lib.finixSystem;
              module = {
                networking.hostName = lib.mkDefault name;
              };
            }
          ];
        }
      )
    );
  };
  config.flake = {
    flake-file.inputs.finix.url = "github:finix-community/finix";
    nixosConfigurations = cfg.configurations |> lib.mapAttrs (_name: { evaluation, ... }: evaluation);

    checks =
      config.flake.nixosConfigurations
      |> lib.mapAttrsToList (
        name: nixos: {
          ${nixos.config.nixpkgs.hostPlatform.system} = {
            "configurations:nixos:${name}" = nixos.config.system.build.toplevel;
          };
        }
      )
      |> lib.mkMerge;
  };
}
