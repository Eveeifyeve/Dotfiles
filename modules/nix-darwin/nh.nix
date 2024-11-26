{
  pkgs,
  config,
  inputs,
  ...
}:
{
  programs.nh = {
    enable = true;
    clean.enable = false; # TODO: Change this when you get rid of the gc.
    # package = inputs.nh_darwin.packages.${pkgs.stdenv.hostPlatform.system}.default;
  };
}
