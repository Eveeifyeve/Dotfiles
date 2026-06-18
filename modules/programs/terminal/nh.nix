{
  homeManager.modules.base = {
    programs.nh = {
      enable = true;
      flake = "/etc/nixos";
      clean.enable = true;
    };
  };
}
