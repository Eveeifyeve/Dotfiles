{
  nixos.modules.base = {
    security = {
      sudo.enable = false;
      sudo-rs.enable = true;
    };
  };
}
