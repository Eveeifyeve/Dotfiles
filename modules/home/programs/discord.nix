{ }:
{
  programs.discord = {
    config = {
      useQuickCss = false;
      frameless = true;
      plugins = {
        silentTyping = {
          enable = true;
          showIcon = true;
        };
        readAllNotificationsButton.enable = true;
        appleMusicRichPresence.enable = true;
        hideAttachments.enable = true;
      };
    };
  };
}
