{ lib, ... }:
{
  darwin.modules.base =
    { pkgs, ... }:
    {
      nix.settings.system-features = [
        "nixos-test"
        "apple-virt"
      ];
      nix.linux-builder = {
        enable = false;
        ephemeral = true;
        package = pkgs.darwin.linux-builder;
        mandatoryFeatures = [ "nixos-test" ];
        config = {
          boot.binfmt.emulatedSystems = [ "x86_64-linux" ]; # Allows to emulated for building for more archtechures
          nix.settings.experimental-features = "nix-command flakes";
          security.sudo.wheelNeedsPassword = false; # Allows the ability to ssh into the builder for any reason.
          users.users."builder".extraGroups = [ "wheel" ];
          virtualisation.diskSize = lib.mkForce (1024 * 100);
          virtualisation.cores = 5;
        };
      };
    };
}
