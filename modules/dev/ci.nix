{ config, ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      files.file."atelier.toml".source = (pkgs.formats.toml { }).generate "atelier.toml" {
        inherit (config) systems;
        include = [
          "devShells.*.default"
          "checks.*"
        ];
      };
    };
}
