{ pkgs, ... }:
{
  programs.nh = {
    enable = true;
    clean = {
      enable = false; # TODO:Enable this when switching over from gc
    };
  };
}
