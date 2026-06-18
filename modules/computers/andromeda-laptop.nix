{ config, ... }:
{
  darwin.configurations.andromeda-laptop.module = {
    nixpkgs.hostPlatform.system = "aarch64-darwin";
    system.stateVersion = 7;
    imports = with config.darwin.modules; [
      base
      gui
    ];
  };
}
