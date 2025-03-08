{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  inherit (pkgs.stdenv) isDarwin isLinux;
  cfg = config.modules.ghostty;
in
{
  options.modules.ghossty.enable = mkEnableOption "Enables ghostty";
  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      (mkIf isDarwin {
        homebrew.casks = [ "ghostty@tip" ];
      })
      (mkIf isLinux {
        home.packages = [
          pkgs.ghostty
        ];
      })
    ]
  );
}
