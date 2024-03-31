{config, pkgs, lib, ...}: {
  # Home-Manager Config
  home.stateVersion = "22.05";

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

    home.packages = with pkgs; [
      neovim
      discord
      git
      vscode
      nil
      raycast

    ] ++ lib.optionals stdenv.isDarwin [
      # Optional MACOS Stuff
  ];
}
