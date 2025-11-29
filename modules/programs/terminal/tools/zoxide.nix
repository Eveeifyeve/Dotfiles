{
  homeManager.modules.base = {
    programs.zoxide = {
      enable = true;
      options = [ "--cmd cd" ];
    };
  };
}
