# { lib, ... }:
{
  # homeManager.modules.base =
  #   { pkgs, ... }:
  #   {
  #     programs = {
  #       nushell = {
  #         enable = true;
  #         configFile.text = ''
  #           ${lib.getExe pkgs.fastfetch}
  #         '';
  #       };
  #     };
  #   };
}
