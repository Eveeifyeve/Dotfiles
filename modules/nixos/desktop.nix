{
  pkgs,
  inputs,
  lib,
  ...
}:
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
    displayManager.defaultSession = "niri";
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
      enable = true;
      enable32Bit = true;
    };
  };

  xdg.portal = {
    enable = true;
    config.common.default = "*";
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gnome
      libportal
    ];
  };

  programs.niri.enable = true;
  niri-flake.cache.enable = true;

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    MOZ_ENABLE_WAYLAND = "1";
  };
}
