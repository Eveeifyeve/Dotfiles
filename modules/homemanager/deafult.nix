{
  config,
  pkgs,
  username,
  ...
}:
{
  imports = [ ./git.nix ./terminal.nix];
  programs = {
    home-manager.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    gpg.enable = true;
    ssh.enable = true;
  };
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    warn-dirty = false;
  };
  nixpkgs.config = {
    allowUnfree = true;
  };
  home = {
    file = {
      ".tmux.conf".source = ./tmux.conf;
    };
  };
}
