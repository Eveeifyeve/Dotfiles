{
  homebrew-cask,
  homebrew-core,
  homebrew-cask-versions,
  username,
  ...
}:
{
  nix-homebrew = {
    user = "${username}";
    enable = true;
    enableRosetta = false;
    taps = {
      "homebrew/homebrew-core" = homebrew-core;
      "homebrew/homebrew-cask" = homebrew-cask;
      "homebrew/homebrew-cask-versions" = homebrew-cask-versions;
    };
    mutableTaps = false;
    autoMigrate = false; # Already have homebrew use this to migrate to the nix version.
  };
}
