{
  homeManager.modules.gui =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.blender ];
    };
}
