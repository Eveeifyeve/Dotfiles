{ inputs, ... }:
{
  flake.modules.nixos.nixos-1 = {
    imports = with inputs.self.modules.nixos; [
      # keep-sorted start block=yes newline_separated=no
      default-diskconf
      eveeifyeve
      {
        disko.devices.disk.main.device = "/disk/by-label/vda";
        networking.hostName = "eveeifyeve"; # Required for comin
      }
      # keep-sorted end
    ];
  };
}
