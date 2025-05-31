{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption mkPackageOption mkOption;
  cfg = config.programs.discord;
in
{
  options.programs.discord = {
    enable = mkEnableOption "social media for gamers" // {
      default = true;
    };

    app = {
      enable = mkEnableOption "enables discord app";
      package = mkPackageOption pkgs "discord";
      vencord.enable = mkEnableOption "installs vencord";
    };

    vesktop = {
      enable = mkEnableOption "Enables vesktop" // {
        default = true;
      };
      package = mkPackageOption pkgs "vesktop";
    };

    config = mkOption {
      type = lib.types.attrs;
      default = { };
    };
  };

  config = lib.mkIf cfg.enable {
    nixcord = {
      enable = true;
      discord = cfg.app;
      vesktop = cfg.vesktop;
      config = cfg.config;
    };
  };
}
