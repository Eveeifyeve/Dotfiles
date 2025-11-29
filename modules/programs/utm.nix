{
  homeManager.modules.gui =
    { pkgs, lib, ... }:
    {
      home.packages = lib.mkIf pkgs.stdenv.hostPlatform.isDarwin [ pkgs.utm ];
    };
}
