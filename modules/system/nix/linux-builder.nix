{
  darwin.modules.base =
    { pkgs, ... }:
    {
      nix.linux-builder = {
        enable = true;
        package = pkgs.darwin.linux-builder-vz;
        ephemeral = true;
      };
    };
}
