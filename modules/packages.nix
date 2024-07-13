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

      # Virtualization & Testing
      qemu

      # Fonts
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ]