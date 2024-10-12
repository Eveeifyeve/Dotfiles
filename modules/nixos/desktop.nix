{ pkgs, inputs, ... }:
let
  hypr-unstable-pkgs = inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.system};
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
  };

  hardware = {
    graphics = {
      package = hypr-unstable-pkgs.mesa.drivers;
      enable = true;
      enable32Bit = true;
      extraPackages = [ pkgs.amdvlk ];
      extraPackages32 = [ pkgs.driversi686Linux.amdvlk ];
    };
    enableRedistributableFirmware = true;
  };

  # Hyprland x wayland
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    config = {
      common = {
        default = [
          "hyprland"
          "gtk"
        ];
        hyprland = [
          "hyprland"
          "gtk"
        ];
      };
    };
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
  };
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  };
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
  };
}
