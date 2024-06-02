{
  config,
  pkgs,
  lib,
  username,
  email,
  ...
}:
{
  programs.home-manager.enable = true;
  programs.zsh.enable = true;
  imports = [ ../../modules/programs.nix ];
  home = {
    username = username;
    stateVersion = "24.05";
    homeDirectory = "/Users/${username}";
    packages = with pkgs; [
      # Development Tools 
      vscode
      direnv
      devenv
      gradle
      btop
      ripgrep
      jd-gui
      docker

      # Command Line Proccesors 
      eza 
      jq 
      gnused
      gawk 

      # Programs
      spotify
      raycast
      discord
      audacity
      postman
      iterm2

      # Command Line Interface(CLI) Tools 
      starship


      # Nix Tools
      nixd
      nil

      # Fonts
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ];
    sessionPath = [
      "$HOME/.local/bin"
      "/usr/local/bin"
      "/run/current-system/sw/bin"
      "/etc/profiles/per-user/eveeifyeve/bin"
    ];
    shellAliases = {
      proc = "ps u | head -n1 && ps aux | rg -v '\\srg\\s-\\.' | rg";
      nix-rebuid = "darwin-rebuild switch --flake ~/.dotfiles";
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

  programs.zsh.oh-my-zsh = {
    enable = true;
    plugins = [];
    
  };

  # Nix Settings
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    allowed-users = [
      "eveeifyeve"
      "root"
    ];
    warn-dirty = false;
  };
  nixpkgs.config = {
    allowUnfree = true;
  };
}
