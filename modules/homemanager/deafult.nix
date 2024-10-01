{
  config,
  pkgs,
  username,
  ...
}:
{
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
		sandbox = true;
  };
  nixpkgs.config = {
    allowUnfree = true;
  };
 }
