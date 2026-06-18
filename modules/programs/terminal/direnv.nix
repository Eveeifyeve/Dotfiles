{ inputs, ... }:
{
  flake-file.inputs.direnv-instant = {
    url = "github:Mic92/direnv-instant";
    inputs.nixpkgs.follows = "nixpkgs";
    inputs.flake-parts.follows = "flake-parts";
  };

  homeManager.modules.base = {
    imports = [
      inputs.direnv-instant.homeModules.direnv-instant
    ];

    programs.direnv-instant.enable = true; # Automatically enables direnv
    programs.direnv.nix-direnv.enable = true;
  };
}
