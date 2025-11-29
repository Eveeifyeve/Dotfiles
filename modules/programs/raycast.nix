{ lib, ... }:
{
  nixpkgs.config.allowUnfreePackages = [ "raycast" ];
  homeManager.modules.gui =
    { pkgs, ... }:
    {
      home.packages = lib.mkIf pkgs.stdenv.isDarwin [ pkgs.raycast ];
    };
}
