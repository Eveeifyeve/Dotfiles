{
  homeManager.modules.gui =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.element-desktop ];
    };
}
