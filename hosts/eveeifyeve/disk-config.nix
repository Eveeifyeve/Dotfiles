{
  disko.devices = {
    disk = {
      main = {
        device = "/dev/disk/by-id/ata-ST2000DM008-2FR102_ZFL3HCWY";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            boot = {
              size = "1M";
              type = "EF02"; # for grub MBR
            };
            root = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
              };
            };
          };
        };
      };
    };
  };
}
