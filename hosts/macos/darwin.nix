{config, pkgs, ...}: {
nix.settings.experimental-features = "nix-command flakes";
nix.settings.allowed-users = [ "eveeifyeve" "root" ];
nixpkgs.hostPlatform = "aarch64-darwin";
nixpkgs.config.allowUnfree = true;
services.nix-daemon.enable = true;
system.stateVersion = 4;
programs.zsh.enable = true;
}
