{
  inputs,
  lib,
  ...
}:
{
  imports = [ (inputs.files + "/flake-module.nix") ];
  flake-file.inputs.files = {
    url = "github:mightyiam/files";
    flake = false;
  };

  perSystem = psArgs: {
    treefmt.settings.global.excludes = lib.attrNames psArgs.config.files.file;
    files.writer.app = true;
  };
}
