{
  homeManager.modules.gui =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.pandora-launcher
      ];
    };
}
