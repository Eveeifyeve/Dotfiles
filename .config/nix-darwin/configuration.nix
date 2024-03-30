{pkgs, ...}: {
# Nix-Darwin Config
services.nix-daemon.enable = true;
  nix.settings.experimental-features = "nix-command flakes";
  nix.settings.allowed-users = [ "eveeifyeve" "root" ];
  nixpkgs.config.allowUnfree = true;
}