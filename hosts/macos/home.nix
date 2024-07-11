{
  config,
  pkgs,
  lib,
  username,
  email,
  ...
}:
{
  imports = [ ../../modules/home-manager.nix ../../modules/cachix/default.nix ];
  home = {
    username = username;
    stateVersion = "24.05";
    homeDirectory = "/Users/${username}";
    packages = with pkgs; [
      # Calls Packages that I want to share
      callPackage ../../modules/packages.nix { }

      # MacOS Specific/Special Apps
      aldente
      bartender
      raycast
      iterm2
    ];
    sessionPath = [
      "$HOME/.local/bin"
      "/usr/local/bin"
      "/run/current-system/sw/bin"
      "/etc/profiles/per-user/eveeifyeve/bin"
    ];
    shellAliases = {
      proc = "ps u | head -n1 && ps aux | rg -v '\\srg\\s-\\.' | rg";
      nix-rebuid = "sudo darwin-rebuild switch --flake ~/.dotfiles --verbose |& nom";
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
  nix.settings.allowed-users = [
      "eveeifyeve"
      "root"
    ];
}
