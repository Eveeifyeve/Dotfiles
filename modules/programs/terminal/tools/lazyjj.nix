{
  homeManager.modules.gui =
    { pkgs, ... }:
    {
      home.shellAliases.ljj = "lazyjj";
      home.packages = [ pkgs.lazyjj ];
    };
}
