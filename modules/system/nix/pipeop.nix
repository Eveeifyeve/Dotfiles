{
  flake-file.nixConfig.extra-experimental-features = [ "pipe-operators" ];
  nix.settings.experimental-features = [
    "pipe-operators"
  ];
}
