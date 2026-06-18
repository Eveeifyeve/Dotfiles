{
  homeManager.modules.gui =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.libreoffice-bin ];
    };
}
