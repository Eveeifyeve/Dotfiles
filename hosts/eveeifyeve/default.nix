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

  virtualisation = {
    docker.enable = true;
    podman.enable = true;
  };

  services = {
    openssh.enable = true;
  };

  # Time

  networking.timeServers = [
    "time.nist.gov"
    "time.windows.com"
  ];
  time.timeZone = "Australia/Sydney";

  security.rtkit.enable = true;

  nix.settings.trusted-users = [
    "root"
    "@wheel"
  ];

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
      ];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOjXW/SwJGY8IjMi9u238xhN7njeruqtDuDeaUy00wPM eveeifyeve@eveeifyeve-macbook"
      ];
    };
  };
  #TODO: Remove this and use suggested roadmap
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "24.05";
}
