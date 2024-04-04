{config, pkgs, lib, ...}: {
  imports = [
    ../../home-manager/git.nix
    ../../home-manager/nvim.nix
  ];

  # Home-Manager Config
  home.stateVersion = "22.05";
  programs.home-manager.enable = true;
    home.packages = with pkgs; [
      neovim
      discord
      git
      vscode
      nil
      spotify
      raycast
      direnv
    ] ++ lib.optionals stdenv.isDarwin [
      # Optional MACOS Stuff
  ];
  
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    warn-dirty = false;
  };

}
