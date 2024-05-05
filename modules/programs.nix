{ config, pkgs, username, email, ... }:
{
 programs = {
  tmux = {
    enable = true;
    plugins = with pkgs; [ tmuxPlugins.catppuccin ];
    extraConfig = builtins.readFile ../tmux.conf;
  };
  git = {
    enable = true;
    extraConfig = {
      core.editor = "vscode";
      credential.helper = "store";
      github.user = username;
      push.autoSetupRemote = true;
    };
    userEmail = email;
    userName = username;
  };
 };
  home.file = {
    ".tmux.conf".source = ../tmux.conf;
  };
}