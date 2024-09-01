{
  config,
  pkgs,
  git,
  lib,
  ...
}:
{
  imports =
  [
    ../../modules/homemanager/deafult.nix
    ../../modules/homemanager/git.nix
    ../../modules/homemanager/terminal.nix
  ];
  home = {
    username = "eveeifyeve";
    stateVersion = "24.05";
    homeDirectory = "/Users/${config.home.username}";
    packages =
      pkgs.callPackage ../../modules/packages.nix { }
      ++ (with pkgs; [
        # MacOS Specific/Special Apps
        mas
        aldente
        bartender
        arc-browser
        raycast # MacOS Spotlight Alternative
        iterm2 # MacOS Terminal
        utm # MacOS Qemu
        # darwin.xcode_15_1
      ]);
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
      frequency = "daily";
      options = "--delete-older-than 30d";
    };
    extraOptions = ''
    auto-optimise-store = true
    '';
  };
}
