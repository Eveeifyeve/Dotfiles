{ inputs, ... }:
{
  imports = [ inputs.git-hooks.flakeModule ];
  flake-file.inputs = {
    git-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-compat.follows = "flake-compat";
    };
  };

  perSystem =
    psArgs@{ pkgs, ... }:
    {
      pre-commit.settings.hooks = {
        treefmt.enable = true;
        deadnix.enable = true;
        flake-checker.enable = true;

        commitizen.enable = true;
        check-merge-conflicts.enable = true;
      };

      devShells.default = pkgs.mkShell {
        inputsFrom = [
          psArgs.config.pre-commit.devShell
          psArgs.config.formatter
        ];
      };
    };
}
