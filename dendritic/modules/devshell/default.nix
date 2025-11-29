{ inputs, ... }:
{
  flake-file = {
    treefmt.url = "github:numtide/treefmt-nix";
    git-hooks.url = "github:cachix/git-hooks.nix";
    devshell = {
      url = "github:numtide/devshell";
      inputs.nixpkgs.follows = "dev-nixpkgs";
    };
  };

  imports = [
    inputs.treefmt-nix.flakeModule
    inputs.devshell.flakeModule
    inputs.git-hooks-nix.flakeModule
  ];

}
