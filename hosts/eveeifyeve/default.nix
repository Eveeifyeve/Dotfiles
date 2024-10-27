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

  users = {
    mutableUsers = false;
    users."eveeifyeve" = {
      name = "eveeifyeve";
      isNormalUser = true;
      hashedPassword = "$y$j9T$9Zg/83oVXDFMkTw27K2d5/$1SqsLU1.RbN.bPYsRZxL39p.k6F2XGXvJ9Aeq0ad718";
      shell = pkgs.zsh;
      extraGroups = [
        "nixos-config"
        "wheel"
      ];
    };
  };
  nixpkgs.config = {
    allowUnfree = true;
    nvidia.acceptLicense = true;
  };
  programs.zsh.enable = true;

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOjXW/SwJGY8IjMi9u238xhN7njeruqtDuDeaUy00wPM eveeifyeve@eveeifyeve-macbook"
  ];

  system.stateVersion = "24.05";
}
