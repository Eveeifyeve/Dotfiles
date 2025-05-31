{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption mkPackageOption;
  cfg = config.services.deskflow;
in
{
  options.programs.deskflow = {
    enable = mkEnableOption "A keyboard and mouse sharer";
    package = mkPackageOption pkgs "deskflow" { };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      cfg.package
    ];
  };
}
