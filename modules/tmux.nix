{ pkgs, home, ... }:
{
  programs.tmux = {
    enable = true;
    plugins = with pkgs; [ tmuxPlugins.catppuccin ];
    extraConfig = builtins.readFile ../tmux.conf;
  };
  home.file.".tmux.conf".source = ../tmux.conf;
}
