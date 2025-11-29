{ inputs, ... }:
{
  flake-file.inputs = {
    treefmt.url = "github:numtide/treefmt-nix";
    git-hooks.url = "github:cachix/git-hooks.nix";
    devshell = {
      url = "github:numtide/devshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  imports = [
    inputs.treefmt.flakeModule
    inputs.devshell.flakeModule
    inputs.git-hooks.flakeModule
  ];

  perSystem =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    {
      #NOTE: Formatters/Linters (Non-commit)
      treefmt = {
        projectRootFile = "flake.nix";
        programs = {
          nixfmt.enable = true;
          ruff-format.enable = true;
          ruff-check.enable = true;
        };
        settings.global.exclude = [
          "LICENCE"
          "flake.nix" # Generated
          "*.age"
          ".jj/*"
        ];
      };

      #NOTE: Commit hooks for formatting and linting.
      pre-commit.settings.hooks = {
        treefmt.enable = true;
        deadnix.enable = true;
        flake-checker.enable = true;

        commitizen.enable = true;
        check-merge-conflicts.enable = true;
      };

      # Devshell
      #NOTE: used numtide so it's easier to manage the config
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
            name = "refresh-workflows";
            help = "Refreshes the workflows defined in nix";
            command = ''
              mkdir -p $out/.github/workflows
              cp -r ${config.githubActions.workflowsDir}/* $out/.github/workflows/
            '';
          }
          {
            name = "new-module";
            help = "creates a new module";
            command = ''${pkgs.python3.interpreter} ${./new-module.py} "$@"'';
          }
        ];
      };
    };
}
