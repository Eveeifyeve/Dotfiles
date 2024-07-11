{pkgs, ...}:
with pkgs; 
[
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
      discord
      audacity
      postman

      # Nix Tools
      nixd
      nil
      nix-output-monitor

      # Fonts
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ];