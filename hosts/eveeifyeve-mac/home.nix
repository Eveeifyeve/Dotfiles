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
  home = {
    username = "eveeifyeve";
    stateVersion = "24.05";
    homeDirectory = "/Users/${config.home.username}";
    packages =
      pkgs.callPackage ../../modules/packages.nix { inherit inputs; }
      ++ (with pkgs; [
        mas
        aldente
        bartender
        arc-browser
        raycast # MacOS Spotlight Alternative
        iterm2 # MacOS Terminal
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
