{
  lib,
  pkgs,
  config,
  inputs,
  ...
}:
{
  imports = [
    ./disk-config.nix
    ../../modules/nixos/games.nix
    ../../modules/nixos/desktop.nix
    ../../modules/nixos/nh.nix
  ];
  boot.loader = {
    efi.canTouchEfiVariables = true;
    systemd-boot.enable = true;
  };

  programs.regreet.enable = true;
  virtualisation = {
    podman = {
      enable = true;
      dockerSocket.enable = true;
      dockerCompat = true;
    };
    libvirtd.enable = true;
  };

  services.fwupd.enable = true;

  environment.variables.AMD_VULKAN_ICD = "RADV";

  programs.virt-manager.enable = true;

  services = {
    openssh.enable = true;
    hardware.openrgb = {
      enable = true;
      package = pkgs.openrgb-with-all-plugins;
      motherboard = "amd";
    };
    avahi = {
      enable = true;
      openFirewall = true;
      nssmdns6 = true;
      publish = {
        enable = true;
        userServices = true;
      };
    };
  };

  # NDI Firewall
  networking.firewall = {
    allowedTCPPorts = [
      5959
      5960
      5961
    ];
    allowedTCPPortRanges = [
      {
        from = 6960;
        to = 8000;
      }
      {
        from = 7960;
        to = 9000;
      }
    ];
    allowedUDPPortRanges = [
      {
        from = 6960;
        to = 8000;
      }
      {
        from = 7960;
        to = 9000;
      }
    ];
  };

  programs.gnupg.agent.enable = true;

  # Time

  networking.timeServers = [
    "time.nist.gov"
    "time.windows.com"
  ];
  time.timeZone = "Australia/Sydney";

  security.rtkit.enable = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.settings = {
    trusted-users = [
      "root"
      "@wheel"
    ];
  };

  users = {
    mutableUsers = false;
    users."eveeifyeve" = {
      name = "eveeifyeve";
      isNormalUser = true;
      hashedPassword = "$y$j9T$el54ntrvfuizFVgxHYJhr.$HE0tdKIH0FOXHdTBeq.txlLcN90cauacPQwh4y81iI3";
      shell = pkgs.nushell;
      extraGroups = [
        "nixos-config"
        "wheel"
        "libvirtd"
      ];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIA4+rTHpcB+TbPZeofrqnEtoduSPqlH1IAV5AsM1DIkU eveeifyeve@eveeifyeve-macbook"
      ];
    };
  };
  #TODO: Remove this and use suggested roadmap
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "25.11";
}
