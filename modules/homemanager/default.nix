{
  config,
  pkgs,
  lib,
  username,
  ...
}:
{
  programs = {
    home-manager.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    vscode = {
      enable = true;
      package = pkgs.vscodium;
      profiles.default = {
        userSettings = {
          editor.fontFamily = "JetBrains Mono";
        };
        extensions = with pkgs.vscode-extensions; [
          ms-vsliveshare.vsliveshare
          astro-build.astro-vscode
          vscodevim.vim
        ];
      };
    };

    lazygit = {
      enable = true;
      settings = {
        gui.switchTabsWithPanelJumpKeys = true;
      };
    };

    nixcord = {
      enable = true;

      # Disable other discords and only use vesktop (Linux)
      discord.enable = false;

      userPlugins = {
        #vimMotion = "github:404-5971/vimMotion/85da8d7d756c87b91bf0e794c52785fa6f13bb61";
      };

      vesktop = {
        enable = true;
        settings.arRPC = true;
      };
      config = {
        useQuickCss = false;
        frameless = true;
        plugins = {
          silentTyping = {
            enable = true;
            chatIcon = true;
          };
          noBlockedMessages.enable = true;
          readAllNotificationsButton.enable = true;
          appleMusicRichPresence.enable = true;
          hideMedia.enable = true;
          volumeBooster.enable = true;
        };
      };
    };

    gpg.enable = true;
    password-store = {
      enable = true;
      settings = {
        PASSWORD_STORE_DIR = "${config.xdg.dataHome}/password-store";
        PASSWORD_STORE_KEY = "EBA9DF00EE9717990BC39BDCBAA8C2C616D55AB3";
      };
    };
    zoxide = {
      enable = true;
      enableZshIntegration = true;
      enableNushellIntegration = true;
      options = [ "--cmd cd" ];
    };
    ssh.enable = true;
  };
  home.shellAliases = {
    # proc = "ps u | head -n1 && ps aux | rg -v '\\srg\\s-\\.' | rg";
    #  gitr = ''
    #    	gitr () {
    #    		for f in $(find . -type d -name .git | awk -F"/.git$" '{print $1}');  do
    #    			echo
    #    			echo "................................ (cd $f && git $*) ........................................."
    #    			echo
    #    			(cd $f && git $*)
    #    		done
    #    }
    #  '';
    cat = "bat";
  };
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    auto-optimise-store = true;
    warn-dirty = false;
    #access-tokens = "github.com=$(gh auth token)";
  };
}
