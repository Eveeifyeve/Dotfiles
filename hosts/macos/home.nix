{
  config,
  pkgs,
  lib,
  username,
  ...
}:
{
  imports = [ ../../modules/homemanager/deafult.nix ../../modules/cachix/default.nix ../../modules/homemanager/git.nix ../../modules/homemanager/terminal.nix ];
  home = {
    username = username;
    stateVersion = "24.05";
    homeDirectory = "/Users/${username}";
    packages = pkgs.callPackage ../../modules/packages.nix { } ++ [
      # MacOS Specific/Special Apps
      pkgs.mas
      pkgs.aldente
      pkgs.bartender
      pkgs.raycast # MacOS Spotlight Alternative
      pkgs.iterm2 # MacOS Terminal
      pkgs.utm # MacOS Qemu
    ];
    sessionPath = [
      "$HOME/.local/bin"
      "/usr/local/bin"
      "/opt/homebrew/bin"
      "/run/current-system/sw/bin"
      "/etc/profiles/per-user/eveeifyeve/bin"
    ];
    shellAliases = {
      proc = "ps u | head -n1 && ps aux | rg -v '\\srg\\s-\\.' | rg";
      nix-rebuild = "darwin-rebuild switch --flake ~/.dotfiles --verbose |& nom";
      nix-direnv = "echo use flake . --impure > .envrc";
      gitr = ''
              gitr () {
            for f in $(find . -type d -name .git | awk -F"/.git$" '{print $1}');  do
            echo
            echo "................................ (cd $f && git $*) ........................................."
            echo
            (cd $f && git $*)
          done
        }
      '';
    };
  };
  nix = {
    settings.allowed-users = [
        "eveeifyeve"
        "root"
      ];
    gc = {
      automatic = true;
      frequency = "weekly";
      options = "--delete-older-than 14d";
    };
  };
}
