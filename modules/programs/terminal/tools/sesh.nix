{
  homeManager.modules.base = {
    programs.sesh = {
      enable = true;
      settings = {
        session = [
          {
            name = "Config";
            path = "/etc/nixos";
            startup_command = "bash -c 'tmux split-window -v -l 25%; tmux select-pane -t .0; exec nvim .'";
          }
        ];
      };
    };
  };
}
