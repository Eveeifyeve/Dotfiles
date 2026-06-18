{
  config,
  lib,
  evalModulesModule,
  ...
}:
let
  cfg = config.nixos;
in
{
  options.nixos = {
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
                fn = lib.nixosSystem;
                module = {
                  networking.hostName = lib.mkDefault name;
                };
              }
            ];
          }
        )
      );
    };
  };

  config.flake = {
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
