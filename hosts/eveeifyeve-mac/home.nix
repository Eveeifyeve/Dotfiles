{
  config,
  pkgs,
  git,
  lib,
  inputs,
  ...
}:
{
  imports = [
    ../../modules/homemanager
    ../../modules/homemanager/git.nix
    ../../modules/homemanager/terminal.nix
  ];
  programs.alacritty = {
    enable = true;
  };
  home = {
    username = "eveeifyeve";
    stateVersion = "25.05";
    homeDirectory = "/Users/${config.home.username}";
    packages =
      pkgs.callPackage ../packages.nix { inherit inputs; }
      ++ (with pkgs; [
        mas
        aldente
        bartender
        stats
        raycast # MacOS Spotlight Alternative
        utm # MacOS Qemu
        # darwin.xcode_15_1
      ]);
    shellAliases.nix-rebuild = "darwin-rebuild switch --flake ~/.dotfiles --verbose |& nom";
  };
  nix.settings.allowed-users = [
    "eveeifyeve"
    "root"
  ];
}
