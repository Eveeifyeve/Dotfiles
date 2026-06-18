{
  nixpkgs.config.allowUnfreePackages = [ "idea" ];
  homeManager.modules.gui =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.jetbrains.idea ];
    };
}
