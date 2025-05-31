{ inputs, ... }:
{
  inputs = [
    ./hosts
  ];

  flake.nixosModules.default = ./modules;
}
