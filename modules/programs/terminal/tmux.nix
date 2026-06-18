{
  homeManager.modules.base =
    { pkgs, ... }:
    {
      programs.tmux = {
        enable = true;
        mouse = true;
        prefix = "C-s";
        keyMode = "vi";
        newSession = true;
        disableConfirmationPrompt = true;
        plugins = with pkgs; [
          {
            plugin = tmuxPlugins.resurrect;
            extraConfig = ''
              set -g @resurrect-strategy-nvim 'session'
              set -g @resurrect-save 'S'
              set -g @resurrect-restore 'R'
            '';
          }
          {
            plugin = tmuxPlugins.continuum;
            extraConfig = ''
              							set -g @continuum-restore 'on'
              							set -g @continuum-boot 'on'
              							set -g @continuum-save-interval '10'
            '';
          }
        ];
      };
    };
}
