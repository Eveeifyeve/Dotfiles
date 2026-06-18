{
  inputs,
  lib,
  config,
  ...
}:
let
  cfg = config.sops;
in
{
  options = {
    users = lib.mkOption {
      type = lib.types.lazyAttrsOf (
        lib.types.submodule (userArgs: {
          options = {
            sops = {
              age-plugins = lib.mkOption {
                type = lib.types.listOf lib.types.package;
                default = [
                  userArgs.pkgs.age-plugin-se
                  userArgs.pkgs.age-plugin-tpm
                ];
              };

              key = lib.mkOption {
                type = lib.types.str;
                default = "";
              };

              key_type = lib.mkOption {
                type = lib.types.enum [
                  "age"
                  "pgp"
                ];
                default = "age";
              };

              creation-rules = lib.mkOption {
                type = lib.types.listOf lib.types.str;
                default = [ ];
                apply =
                  rules:
                  let
                    mkKeyGroup =
                      type:
                      if userArgs.config.sops.key != null && userArgs.config.sops.key_type == type then
                        # Leverage an object structure that formats.yaml evaluates as an unquoted token
                        [ "*eveeifyeve" ]
                      else
                        null;
                  in
                  map (rulePath: {
                    path_regex = rulePath;
                    key_groups = [
                      (lib.filterAttrs (_: v: v != null) {
                        pgp = mkKeyGroup "pgp";
                        age = mkKeyGroup "age";
                      })
                    ];
                  }) rules;
              };
            };
          };

          config.home.base =
            { pkgs, ... }:
            {
              sops.age.keyFile = lib.mkMerge [
                (lib.mkIf pkgs.stdenv.isLinux "/home/${userArgs.config.username}")
                (lib.mkIf pkgs.stdenv.isDarwin "/Users/${userArgs.config.username}")
              ];
            };

        })
      );
    };

    sops = {
      keys = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [ ];
      };

      creation-rules = lib.mkOption {
        type = lib.types.listOf lib.types.attrs;
        default = { };
      };

      file-keys = lib.mkOption {
        readOnly = true;
        type = lib.types.listOf lib.types.unspecified;
        apply =
          x:
          x
          ++ (
            config.users
            |> lib.filterAttrs (_: user: user.sops.key != null && user.sops.key != "")
            |> lib.mapAttrsToList (_: user: "&${user.username} ${user.sops.key}")
          );
      };
    };
  };

  config = {
    flake-file.inputs.sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops.keys = lib.flatten (lib.mapAttrsToList (_: user: user.sops.key) config.users);
    sops.creation-rules = lib.flatten (
      lib.mapAttrsToList (_: user: user.sops.creation-rules) config.users
    );

    homeManager.modules.base =
      { pkgs, ... }:
      {
        home.sessionVariables.SOPS_AGE_RECIPIENTS = lib.concatStringsSep "," cfg.keys;
        home.packages = [ pkgs.sops ];
        imports = [
          inputs.sops-nix.homeManagerModules.sops
        ];
      };

    perSystem =
      { pkgs, ... }:
      {
        files.file.".sops.yaml".source = (pkgs.formats.yaml { }).generate "sops-yaml" {
          inherit (cfg) creation-rules;
          keys = cfg.file-keys;
        };
      };
  };
}
