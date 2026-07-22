{ lib, ... }:
{
  homeManager.modules.gui =
    { pkgs, ... }:
    let
      nixpkgs-491420-drv = pkgs.applyPatches {
        src = pkgs.path;
        patches = [
          (pkgs.fetchpatch2 {
            url = "https://github.com/NixOS/nixpkgs/pull/491420.patch";
            hash = "sha256-dDfzvSX3B5QSV1AgSm6jhxeaCHspOILqP6qKldrldhc=";
          })
        ];
      };
      nixpkgs-491420 = import nixpkgs-491420-drv {
        inherit (pkgs.stdenv) system;
        config.allowUnfreePackages = [ "roblox" ];
      };
    in
    {
      home.packages = lib.mkIf pkgs.stdenv.isDarwin [ nixpkgs-491420.roblox ];
    };
}
