{ lib, inputs, ... }:
{
  flake-file.inputs.hyprland-scroll-overview = {
    url = "github:yayuuu/hyprland-scroll-overview";
    inputs = {
      nixpkgs.follows = "nixpkgs";
      hyprland.follows = "hyprland";
      flake-parts.follows = "nixpkgs";
    };
  };

  homeManager.modules.gui =
    { pkgs, ... }:
    lib.mkIf pkgs.stdenv.isLinux {
      wayland.windowManager.hyprland.plugins = [
        inputs.hyprland-scroll-overview.packages.${pkgs.stdenv.hostPlatform.system}.scrolloverview
      ];
    };
}
