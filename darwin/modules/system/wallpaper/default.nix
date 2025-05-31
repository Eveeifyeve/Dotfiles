#TODO: Upstream this to nix-darwin and maybe remove this
{ config, lib, ... }:
let
  inherit (lib) mkEnableOption mkOption;
  cfg = config.services.wallpaper;
in
{
  options.services.wallpaper = {
    enable = mkEnableOption "wallpaper for darwin machines";
    image = mkOption {
      description = "The image you want to use";
      type = with lib.types; nullOr path;
    };
  };

  config.system.activationScripts.postActivation.text = lib.mkIf cfg.enable ''
    		sudo osascript -e "tell application \\"Finder\\" to set desktop picture to POSIX file \\"${cfg.image}\\""
    	'';
}
