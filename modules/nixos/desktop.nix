{
  pkgs,
  inputs,
  lib,
  ...
}:
let
  hypr-unstable-pkgs = inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.system};
  hyprpackages = inputs.hyprland.packages.${pkgs.system};
in
{
  services = {
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      jack.enable = true;
    };
    xserver.videoDrivers = [ "amdgpu" ];
    displayManager.defaultSession = "hyprland";
    dbus.enable = true;
    greetd = {
      enable = true;
      settings = {
        default_session = {
          user = "eveeifyeve";
        };
      };
    };
  };

  hardware = {
    enableAllFirmware = true;
    amdgpu.initrd.enable = true;
    graphics = {
      package = hypr-unstable-pkgs.mesa;
      enable = true;
      enable32Bit = true;
      package32 = hypr-unstable-pkgs.pkgsi686Linux.mesa;
    };
  };

  # Hyprland x wayland
  xdg.portal = {
    enable = true;
    config.common.default = "*";
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      libportal
      hyprpackages.xdg-desktop-portal-hyprland
    ];
  };

  programs.hyprland = {
    enable = true;
    package = hyprpackages.hyprland;
    portalPackage = hyprpackages.xdg-desktop-portal-hyprland;
  };
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    MOZ_ENABLE_WAYLAND = "1";
  };
}
