{ inputs, ... }:
{
  nix-homebrew = {
    user = "eveeifyeve";
    enable = true;
    enableRosetta = true;
    taps = {
      "homebrew/homebrew-core" = inputs.homebrew-core;
      "homebrew/homebrew-cask" = inputs.homebrew-cask;
      "homebrew/bundle" = inputs.homebrew-bundle;
      "homebrew/homebrew-cask-versions" = inputs.homebrew-cask-versions;
    };
    mutableTaps = false;
    autoMigrate = false;
  };
}
