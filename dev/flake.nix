{
  description = "Developer enviroment & flake templates";
  nixConfig.commit-lockfile-summary = "chore: update dev flake";

  inputs = {
    dev-nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    git-hooks-nix.url = "github:cachix/git-hooks.nix";
    flake-compat.url = "https://flakehub.com/f/edolstra/flake-compat/1.tar.gz";

    devshell = {
      url = "github:numtide/devshell";
      inputs.nixpkgs.follows = "dev-nixpkgs";
    };
  };

  outputs = inputs: {
  };
}
