{ lib, ... }:
let
  inherit (lib) types;
  cfg = config.homebrew;
in
{
  options.homebrew = {
    user = lib.mkOption {
      type = types.str;
      default = "eveeifyeve";
    };
    install = lib.mkOption {
      type = types.bool;
      default = true;
    };
    rosetta = lib.mkOption {
      type = types.bool;
      default = false;
    };
    taps = {
      type = types.attrsOf types.package;
      default = {
        "homebrew/homebrew-core" = inputs.homebrew-core;
        "homebrew/homebrew-cask" = inputs.homebrew-cask;
        "homebrew/bundle" = inputs.homebrew-bundle;
        "homebrew/homebrew-cask-versions" = inputs.homebrew-cask-versions;
      };
    };
    mutableTaps = lib.mkOption {
      type = types.bool;
      default = false;
    };
    autoMigrate = lib.mkOption {
      type = types.str;
      default = "eveeifyeve";
    };
  };

  config = {
    homebrew = {
      enable = true;
      casks = [
        "homebrew/cask/docker"
        "cloudflare-warp"
        "logitech-g-hub"
      ];
      brews = [
        "brightness" # Adjust Screen Brightness on MacOS using CLI
      ];
      masApps = {
        GarageBand = 682658836;
        TestFlight = 899247664;
        CrystalFetch = 6454431289;
      };
      onActivation.cleanup = "uninstall";
    };

    nix-homebrew.darwinModules.nix-homebrew.nix-homebrew = {
      user = cfg.user;
      enable = cfg.install;
      enableRosetta = cfg.rosetta;
      taps = cfg.taps;
      mutableTaps = cfg.mutableTaps;
      autoMigrate = cfg.autoMigrate;
    };
  };
}
