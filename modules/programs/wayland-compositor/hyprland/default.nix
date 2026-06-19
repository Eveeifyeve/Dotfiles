{ inputs, lib, ... }:
let
  hyprland-packages = pkgs: inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system};
in
{
  flake-file.inputs.hyprland = {
    url = "github:hyprwm/Hyprland";
    inputs = {
      nixpkgs.follows = "nixpkgs";
      systems.follows = "systems";
      pre-commit-hooks.follows = "git-hooks";
    };
  };

  nixos.modules.gui =
    { pkgs, ... }:
    {
      programs.hyprland = {
        enable = true;
        package = (hyprland-packages pkgs).hyprland;
        portalPackage = (hyprland-packages pkgs).xdg-desktop-portal-hyprland;
        xwayland.enable = true;
        withUWSM = true;
      };
    };

  homeManager.modules.gui =
    { pkgs, ... }:
    lib.mkIf pkgs.stdenv.isLinux {
      wayland.windowManager.hyprland.enable = lib.mkDefault true;
    };
}
