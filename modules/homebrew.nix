{ inputs, ... }:
{
  nix-homebrew = {
    user = "eveeifyeve";
    enable = true;
    enableRosetta = true;
    taps = {
      "homebrew/homebrew-core" = inputs.homebrew-core;
      "homebrew/homebrew-cask" = inputs.homebrew-cask;
      "deskflow/homebrew-tap" = inputs.deskflow-homebrew-tap;
    };
    mutableTaps = false;
    autoMigrate = false;
  };
}
