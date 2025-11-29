{
  home.base = hmArgs: {
    programs.ssh = {
      includes = [ "${hmArgs.config.home.homeDirectory}/.ssh/hosts/*" ];
      settings."Host *" = {
        "SetEnv TERM" = "xterm-256color";
        compression = true;
        identitiesOnly = true;
        hashKnownHosts = false;
        identityFile = "${hmArgs.config.home.homeDirectory}/.ssh/id_ed25519";
      };
    };
  };

  # nixos.modules.base = {
  #   users.users.eveeifyeve.openssh.authorizedKeys.keys = [
  #   ];
  # };
}
