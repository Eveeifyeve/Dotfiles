{
  homeManager.modules.base =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.nix-output-monitor ];
    };
}
