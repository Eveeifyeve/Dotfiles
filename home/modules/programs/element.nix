{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption mkPackageOption;
  cfg = config.programs.element;
in
{
  options.programs.element = {
    enable = mkEnableOption "A electron based matrix client";
    package = mkPackageOption pkgs "element" { };
  };

  config.home.packages = lib.mkIf cfg.enable [
    cfg.package
  ];
}
