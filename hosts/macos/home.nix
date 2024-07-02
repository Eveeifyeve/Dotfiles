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
      devenv
      gradle
      btop
      ripgrep
      jd-gui

      # Command Line Proccesors 
      eza
      jq
      gnused
      gawk

      # Programs
      spotify
      raycast
      vesktop
      audacity
      postman
      iterm2

      # Nix Tools
      nixd
      nil

      # MacOS Special Apps
      aldente
      bartender

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
    plugins = [ ];
  };

  programs.starship = {
    enable = true;
    settings = {
      # git_status = {
      #   conflicted = "⚔️ ";
      #   ahead = "🏎️ 💨 ×${count} ";
      #   behind = "🐢 ×${count} ";
      #   diverged = "🔱 🏎️ 💨 ×${ahead_count} 🐢 ×${behind_count} ";
      #   untracked = "🛤️  ×${count} ";
      #   stashed = "📦 ";
      #   modified = "📝 ×${count} ";
      #   staged = "🗃️  ×${count} ";
      #   renamed = "📛 ×${count} ";
      #   deleted = "🗑️  ×${count} ";
      #   style = "bright-white";
      #   format = "$all_status$ahead_behind";
      # };
    };
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
