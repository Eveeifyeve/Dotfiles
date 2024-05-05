{ config, pkgs, ... }:
{
  nix.settings.experimental-features = "nix-command flakes";
  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config.allowUnfree = true;
  services.nix-daemon.enable = true;
  system.stateVersion = 4;
  programs.nixvim.enable = true;
  programs.zsh = {
    enable = true;
  };
  environment.shellAliases = {
    
  };
}
