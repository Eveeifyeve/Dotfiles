{config, pkgs, ...}: {
# Nix-Darwin Config
environment.systemPackages = with pkgs; [
    neovim
    git
];

  homebrew = {
    enable = true;
    casks = [
      "spotify"
      "vscode"
    ];
  };

nix.settings.experimental-features = "nix-command flakes";
nix.settings.allowed-users = [ "eveeifyeve" "root" ];
nixpkgs.hostPlatform = "aarch64-darwin";
 nixpkgs.config.allowUnfree = true;
services.nix-daemon.enable = true;
programs.zsh.enable = true;
system.stateVersion = 4;
}
