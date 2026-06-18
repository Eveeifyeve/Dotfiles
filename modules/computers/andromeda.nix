{ config, ... }:
{
  nixos.configurations.andromeda.module = {
    system.stateVersion = "26.05";
    nixpkgs.hostPlatform = "x86_64-linux";

    disko.devices.disk.main = {
      device = "/dev/disk/by-id/ata-ST2000DM008-2FR102_ZFL3HCWY";
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          boot = {
            name = "boot";
            size = "1M";
            type = "EF02";
          };
          esp = {
            name = "ESP";
            size = "500M";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
            };
          };
          swap = {
            size = "4G";
            content = {
              type = "swap";
              resumeDevice = true;
            };
          };
          root = {
            name = "root";
            size = "100%";
            content = {
              type = "lvm_pv";
              vg = "root_vg";
            };
          };
        };
      };
    };

    imports = with config.nixos.modules; [
      base
      gui
    ];
  };
}
