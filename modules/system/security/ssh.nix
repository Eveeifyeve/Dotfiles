{
  homeManager.modules.base = {
    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;
    };
  };
  nixos.modules.gui = {
    services.openssh.enable = true;
  };

  darwin.modules.gui = {
    services.openssh.enable = true;
  };

}
