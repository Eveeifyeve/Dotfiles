{
  config,
  pkgs,
  email,
  ...
}:
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
        github.user = config.home.username;
        push.autoSetupRemote = true;
      };
      userEmail = email;
      userName = config.home.username;
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
  home.file = {
    ".tmux.conf".source = ../tmux.conf;
  };
  home.shellAliases = {
    "nix-rebuild" = "darwin-rebuild switch --flake ~/.dotfiles";
  };
}
