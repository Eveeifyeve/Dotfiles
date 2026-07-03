{ lib, ... }:
{
  home.gui = {
    programs.halloy.settings = {
      notifications =
        lib.genAttrs [ "direct_message" "highlight" "reaction" ] (_: {
          sound = "bloop";
          show_toast = true;
          request_attention = true;
        })
        // {
          connected.sound = "drop";
          disconnected.sound = "bonk";
        };
      servers = {
        Oftc = {
          server = "irc.oftc.net";
          use_tls = true;
          port = 6697;

          # sasl.external.cert = "/path/to/nick.cer";
          # sasl.external.key = "/path/to/nick.key";
        };
      };
    };
  };
}
