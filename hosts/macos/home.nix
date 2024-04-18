{config, pkgs, lib, ...}: {
  imports = [
    ../../modules/git.nix
  ];

  # Home-Manager Config
  home.stateVersion = "22.05";
  programs.home-manager.enable = true;
    home.packages = with pkgs; [
      neovim
      discord
      discord.override {
        withVencord = true;
      }
      git
      vscode
      nil
      spotify
      raycast
      direnv
      nixd
      devenv
      jetbrains.idea-community # Intellij for kotlin development.
    ] ++ lib.optionals stdenv.isDarwin [
      # Optional MACOS Stuff
  ];
  
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    allowed-users = [ "eveeifyeve" "root" ];
    warn-dirty = false;
  };

}
