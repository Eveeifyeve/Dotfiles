{config, pkgs, lib, ...}: {
  home.stateVersion = "22.05";

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

    home.packages = with pkgs; [

    ] ++ lib.optionals stdenv.isDarwin [
    cocoapods
    m-cli # useful macOS CLI commands
  ];
}