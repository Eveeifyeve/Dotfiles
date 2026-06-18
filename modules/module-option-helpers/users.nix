{
  inputs,
  lib,
  config,
  ...
}:
let
  cfg = config.users;
in
{
  options = {
    users = lib.mkOption {
      type = lib.types.lazyAttrsOf (
        lib.types.submodule (
          userArgs@{ name, ... }:
          {
            options = {
              username = lib.mkOption {
                type = lib.types.singleLineStr;
                default = name;
              };
              name = lib.mkOption {
                type = lib.types.singleLineStr;
                default = name;
              };
              email = lib.mkOption {
                type = lib.types.nullOr lib.types.singleLineStr;
                default = null;
              };
              home = {
                base = lib.mkOption {
                  type = lib.types.deferredModuleWith {
                    staticModules = [ { home.username = lib.mkDefault userArgs.config.username; } ];
                  };
                };
                gui = lib.mkOption {
                  type = lib.types.deferredModule;
                };
                configuration = lib.mkOption {
                  type = lib.types.deferredModule;
                };
              };
            };
            config.home = { inherit (config.homeManager.modules) base gui configuration; };
          }
        )
      );
    };

    home = lib.mkOption {
      type = lib.types.lazyAttrsOf lib.types.deferredModule;
    };
  };
  config = {
    nixos.modules = {
      gui.home-manager.users = cfg |> lib.mapAttrs (_: { home, ... }: home.gui);
      base =
        { pkgs, ... }:
        {
          imports = [ inputs.home-manager.nixosModules.home-manager ];
          users = {
            defaultUserShell = pkgs.zsh;
            users =
              cfg
              |> lib.mapAttrs (
                _:
                { username, ... }:
                {
                  name = username;
                  isNormalUser = true;
                  useDefaultShell = lib.mkDefault true;
                }
              );
          };
          home-manager.users =
            cfg
            |> lib.mapAttrs (
              _:
              { home, ... }:
              {
                imports = [
                  (
                    { osConfig, ... }:
                    {
                      home = {
                        stateVersion = osConfig.system.stateVersion;
                      };
                    }
                  )
                  home.base
                ];
              }
            );
        };
    };

    darwin.modules = {
      gui.home-manager.users = cfg |> lib.mapAttrs (_: { home, ... }: home.gui);
      base =
        { pkgs, ... }:
        {
          imports = [ inputs.home-manager.darwinModules.home-manager ];
          users.users =
            cfg
            |> lib.mapAttrs (
              _:
              { username, ... }:
              {
                name = username;
                home = "/Users/${username}";
                shell = lib.mkDefault pkgs.zsh;
              }
            );
          home-manager.users =
            cfg
            |> lib.mapAttrs (
              _:
              { home, ... }:
              {
                imports = [
                  (
                    { osConfig, ... }:
                    {
                      home = {
                        stateVersion = osConfig.system.nixpkgsRelease;
                      };
                    }
                  )
                  home.base
                ];
              }
            );
        };
    };

    users.eveeifyeve.home = config.home;
  };
}
