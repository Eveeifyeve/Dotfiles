{ lib, baseDirectory, ... }:
let
  dirs = lib.attrNames (
    lib.filterAttrs (name: type: type == "directory") (builtins.readDir baseDirectory)
  );

  collectModules =
    dir:
    let
      dirPath = baseDirectory + "/${dir}";
      entries = builtins.attrNames (builtins.readDir dirPath);
      toModule =
        name:
        let
          nixFile = dirPath + "/${name}.nix";
          defaultNix = dirPath + "/${name}/default.nix";
        in
        if builtins.pathExists nixFile then
          nixFile
        else if builtins.pathExists defaultNix then
          defaultNix
        else
          null;
    in
    builtins.filter (m: m != null) (map toModule entries);

  allModules = lib.flatten (map collectModules dirs);
in
{
  imports = allModules;
}
