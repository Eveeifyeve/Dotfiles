{ lib, ... }:

let
  systems = [
    "x86_64-linux"
    "aarch64-linux"
  ];
in
{
  darwin.modules.base =
    { pkgs, ... }:
    {
      nix.settings.extra-platforms = systems;
      nix.linux-builder = {
        enable = false;
        inherit systems;
        package = pkgs.darwin.linux-builder;
        ephemeral = true;
        mandatoryFeatures = [ "nixos-test" ];
        config = {
          boot.binfmt.emulatedSystems = builtins.filter (
            system: system != "aarch64-linux" && lib.strings.hasSuffix "-linux" system
          ) systems; # Allows to emulated for building for more archtechures
          nix.settings.experimental-features = "nix-command flakes";
          security.sudo.wheelNeedsPassword = false; # Allows the ability to ssh into the builder for any reason.
          users.users."builder".extraGroups = [ "wheel" ];
          virtualisation.diskSize = lib.mkForce (1024 * 100);
          virtualisation.cores = 5;
        };
      };
    };
}
