{ inputs, ... }:
{
  inputs = [
    ./hosts
  ];

  flake.darwinModules.default = ./modules;
}
