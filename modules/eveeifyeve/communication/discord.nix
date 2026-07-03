{
  home.gui.programs.nixcord = {
    userPlugins = {
      #vimMotion = "github:404-5971/vimMotion/85da8d7d756c87b91bf0e794c52785fa6f13bb61";
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
}
