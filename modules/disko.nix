{
  inputs,
  ...
}:
{

  flake-file.inputs.disko = {
    url = "github:nix-community/disko/latest";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  nixos.modules.nixos = {
    imports = [ inputs.disko.nixosModules.disko ];
  };
}
