{ config, ... }:
{
  darwin.configurations.andromeda-macbook.module =
    { pkgs, ... }:
    {
      services.nix-daemon.logFile = "/var/log/nix-daemon.log";
      nixpkgs.hostPlatform.system = "aarch64-darwin";
      nix.settings.trusted-users = [
        "root"
        "@admin"
      ];
      system.stateVersion = 7;
      imports = with config.darwin.modules; [
        base
        gui
      ];

      home-manager.users.eveeifyeve.home.packages = [ pkgs.openlogi ];
    };
}
