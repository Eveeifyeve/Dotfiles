{ inputs, ... }:
{
  imports = [ inputs.treefmt.flakeModule ];
  flake-file.inputs.treefmt = {
    url = "github:numtide/treefmt-nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  perSystem =
    { pkgs, ... }:
    {
      treefmt = {
        projectRootFile = "flake.nix";

        programs = {
          nixfmt = {
            enable = true;
            package = pkgs.nixfmt-rs;
          };

          ruff-format.enable = true;
          ruff-check.enable = true;
          keep-sorted.enable = true;
          statix.enable = true;

          typos = {
            enable = true;
            excludes = [ "*.nix" ];
          };
        };

        settings.global.exclude = [
          "LICENCE"
          "flake.nix"
          "*.age"
          ".jj/*"
        ];
      };
    };
}
