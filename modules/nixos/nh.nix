{ pkgs, ... }:
{
  programs.nh = {
    enable = true;
    clean = {
      enable = false;
      dates = "weekly";
      extraArgs = "--keep 2";
    };
  };
}
