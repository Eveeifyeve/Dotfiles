{ inputs, self', ... }:
{
  imports = [
    inputs.treefmt-nix.flakeModule
    inputs.devshell.flakeModule
    inputs.git-hooks-nix.flakeModule
  ];
  perSystem =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      # Treefmt
      treefmt = {
        projectRootFile = "flake.nix";
        programs.nixfmt.enable = true;
        programs.ruff-format.enable = true;
        programs.ruff-check.enable = true;
        settings.global.exclude = [
          "LICENCE"
          "*.age"
          ".jj/*"
        ];
      };

      # Pre-commit hook
      pre-commit.settings.hooks.treefmt.enable = true;

      # Devshell
      devshells.default = {
        devshell.startup.pre-commit.text = config.pre-commit.installationScript;
        devshell.packages = [ config.formatter ];

        commands = [
          {
            name = "checks";
            help = "run checks";
            command = ''
              echo -e "=> Running flake checks....\n"
              nix flake check
            '';
          }
          {
            name = "format";
            help = "formats the repo";
            command = lib.getExe config.formatter;
          }
          {
            name = "new-module";
            help = "creates a new module";
            command = ''${pkgs.python3.interpreter} ${./new-module.py} "$@"'';
          }
        ];
      };
    };

  flake.templates =
    let
      templatesDir = ./templates;
      warnDefault =
        name: alias: builtins.warn "Deprecated please use ${name} instead of ${name}.default" alias;

      #TODO: deprecate at 26.05 release to nixpkgs-unstable
      throwDefault = name: throw "Deprecated please use ${name} instead of ${name}.default";
    in
    {
      node = {
        path = "${templatesDir}/node";
        description = "Node template";
      };

      python = {
        default = warnDefault "python" self'.templates.python;
        poetry = {
          path = "${templatesDir}/python/poetry";
          description = "Python template with poetry";
        };
        uv = {
          path = "${templatesDir}/python/uv";
          description = "Python template with uv";
        };
        path = "${templatesDir}/python/default";
        description = "Python template";
      };

      rust = {
        default = warnDefault "rust" self'.templates.rust;
        fenix = {
          path = "${templatesDir}/rust/fenix";
          description = "Rust template with fenix";
        };
        rust-overlay = builtins.warn "rust.rust-overlay has been renamed to rust.overlay please migrate to this" self'.templates.rust.overlay;
        overlay = {
          path = "${templatesDir}/rust/rust-overlay";
          description = "Rust template with rust-overlay";
        };
        path = "${templatesDir}/rust/default";
        description = "Rust template";
      };

      zig = {
        path = "${templatesDir}/zig";
        description = "Zig template";
      };
    };
}
