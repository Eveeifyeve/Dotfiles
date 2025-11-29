{
  lib,
  config,
  inputs,
  ...
}:
let
  cfg = config.nix-homebrew;
in
{
  options.nix-homebrew = {
    taps = lib.mkOption {
      type = lib.types.attrsOf lib.types.package;
      default = {
        "homebrew/homebrew-core" = inputs.homebrew-core;
        "homebrew/homebrew-cask" = inputs.homebrew-cask;
      };
    };
  };

  config = {
    flake-file.inputs = {
      nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";

      homebrew-core = {
        url = "github:homebrew/homebrew-core";
        flake = false;
      };
      homebrew-cask = {
        url = "github:homebrew/homebrew-cask";
        flake = false;
      };
    };

    darwin.modules.base = {
      imports = [ inputs.nix-homebrew.darwinModules.nix-homebrew ];
      homebrew.taps = builtins.attrNames cfg.taps;

      nix-homebrew = {
        enable = true;
        mutableTaps = true;
        user = "eveeifyeve";
        inherit (cfg) taps;
      };
    };
  };
}
