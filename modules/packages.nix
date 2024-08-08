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
      tree # File Sizes

      # Command Line Proccesors 
      eza
      jaq # Faster version of jq
      jq # Sometimes jaq doesn't work so I use jq
      bat # Better cat
      ripgrep
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


      # Private Browsing / DarkWeb Browsers
      tor

      # Fonts
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ]