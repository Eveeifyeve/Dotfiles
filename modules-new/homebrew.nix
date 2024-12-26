{ lib, config, inputs, ... }:
let
  inherit (lib) types;
  cfg = config.homebrew;
in
{
  options.homebrew = {
		enable = lib.mkOption {
			types = types.bool;
			default = false;
		};

    casks = lib.mkOption {
      types = types.listOf types.str;
      deafult = [];
    };
    brews = lib.mkOption {
      types = types.listOf types.str;
      deafult = [];
    };

    masApps = {
      types = types.attrsOf types.ints.positive;
      default = {};
    };
    activation = {
      cleanup = lib.mkOption {
        types = types.enum [ "none" "uninstall" "zap" ];
        deafult = "uninstall";
      };
    };

    nix-homebrew = {
      enable = lib.mkOption {
        type = types.bool;
        default = true;
      };
      user = lib.mkOption {
        type = types.nullOr types.str;
        default = cfg.system.username;
      };
      taps = {
        type = types.attrsOf types.package;
        default = {
          "homebrew/homebrew-core" = inputs.homebrew-core;
          "homebrew/homebrew-cask" = inputs.homebrew-cask;
          "homebrew/bundle" = inputs.homebrew-bundle;
          "homebrew/homebrew-cask-versions" = inputs.homebrew-cask-versions;
      };
      rosetta = lib.mkOption {
        type = types.bool;
        default = false;
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
    
  };
};

  config = {
    homebrew = {
      enable = cfg.enable;
      casks = cfg.casks;
        # "homebrew/cask/docker"
        # "cloudflare-warp"
        # "logitech-g-hub"
      brews = cfg.brews;
        # "brightness" # Adjust Screen Brightness on MacOS using CLI
      masApps = cfg.masApps;
        # GarageBand = 682658836;
        # TestFlight = 899247664;
        # CrystalFetch = 6454431289;
      };
      onActivation.cleanup = cfg.activation.cleanup;
    };

    nix-homebrew.darwinModules.nix-homebrew.nix-homebrew = let
      nix-homebrew = cfg.nix-homebrew;
    in {
      user = nix-homebrew.user;
      enable =  if cfg.enable && nix-homebrew.install == true then true else false;
      enableRosetta = nix-homebrew.rosetta;
      taps = nix-homebrew.taps;
      mutableTaps = nix-homebrew.mutableTaps;
      autoMigrate = nix-homebrew.autoMigrate;
    };
  };
}
