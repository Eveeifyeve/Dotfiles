{pkgs, ...}: {
 programs.tmux = {
    enable = true;
     plugins = with pkgs;
      [
         tmuxPlugins.catppuccin
      ];
    extraConfig = builtins.readFile ../tmux.conf;
 };
}