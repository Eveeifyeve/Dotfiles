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

      # Nix Tools
      nixd
      nix-output-monitor


      # Private Browsing / DarkWeb Browsers
      tor

      # Minecraft
      prismlauncher-unwrapped

      # Video/Photo/Graphic Editing
      gimp
      blender

      # Fonts
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ]