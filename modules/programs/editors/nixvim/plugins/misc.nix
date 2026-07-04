{
  nixvim.modules.base = {
    plugins = {
      transparent.enable = true;
      cord.enable = true;
      lualine.enable = true;
      notify.enable = true;
      trouble.enable = true;
      harpoon.enable = true;
      web-devicons.enable = true;
      lazygit.enable = true;
      which-key = {
        enable = true;
        settings.notify = true;
      };

      noice = {
        enable = true;
        settings = {
          notify.enabled = true;
          messages.enabled = true;
        };
      };
    };
  };
}
