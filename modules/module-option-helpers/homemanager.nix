{
  inputs,
  lib,
  ...
}:
{
  options.homeManager = {
    modules = lib.mkOption {
      type = lib.types.lazyAttrsOf lib.types.deferredModule;
    };
  };

  config = {
    flake-file.inputs.home-manager = {
      url = "github:eveeifyeve/home-manager/targets-darwin-persist";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    _module.args.homeManager = inputs.home-manager.lib;

    nixos.modules.base =
      { pkgs, ... }:
      {
        home-manager.backupCommand = lib.getExe' pkgs.trash-cli "trash-put";
      };
    darwin.modules.base =
      { pkgs, ... }:
      {
        home-manager.backupCommand = lib.getExe' pkgs.trash-cli "trash-put";
      };
  };
}
