{ inputs, ... }:
{
  flake-file.inputs.nixcord.url = "github:kaylorben/nixcord";

  flake.modules.homeManager.discord =
    { pkgs, ... }:
    {
      imports = [
        inputs.nixcord.homeModules.nixcord
      ];

      programs.nixcord = {
        enable = true;

        # Disable other discords and only use vesktop (Darwin) & Equibop (Linux)
        discord.enable = false;

        userPlugins = {
          #vimMotion = "github:404-5971/vimMotion/85da8d7d756c87b91bf0e794c52785fa6f13bb61";
        };

        vesktop = {
          enable = pkgs.stdenv.isDarwin;
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
    };
}
