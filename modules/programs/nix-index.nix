{ inputs, ... }:
{
  flake-file.inputs.nix-index-database = {
    url = "github:nix-community/nix-index-database";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  homeManager.modules.base = {
    imports = [ inputs.nix-index-database.homeModules.default ];
    programs.nix-index-database.comma.enable = true;
  };
}
