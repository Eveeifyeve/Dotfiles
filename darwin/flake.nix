{
  description = "Modules & Hosts for Darwin";
  nixConfig.commit-lockfile-summary = "chore: update darwin flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";

  };

  outputs = inputs: { };
}
