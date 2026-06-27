{ inputs, ... }:
{
  flake-file.inputs.nur = {
    url = "github:nix-community/NUR";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  nixpkgs.overlays = [ inputs.nur.overlays.default ];
}
