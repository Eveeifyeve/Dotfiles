{
  nixvim.modules.base = {
    plugins = {
      cmp_luasnip.enable = true;
      luasnip.enable = true;
      friendly-snippets.enable = true;
    };
  };

  homeManager.modules.gui =
    { pkgs, lib, ... }:
    let
      snippetsDir = "${pkgs.vimPlugins.friendly-snippets}/snippets";

      readSnippets =
        dir:
        let
          entries = builtins.readDir dir;
          files = lib.filterAttrs (_: t: t == "regular") entries;
          dirs = lib.filterAttrs (_: t: t == "directory") entries;
          fromFiles = lib.mapAttrs' (name: _: {
            name = lib.removeSuffix ".json" name;
            value = builtins.fromJSON (builtins.readFile "${dir}/${name}");
          }) (lib.filterAttrs (n: _: lib.hasSuffix ".json" n) files);
          fromDirs = lib.foldl' (acc: d: acc // readSnippets "${dir}/${d}") { } (builtins.attrNames dirs);
        in
        fromFiles // fromDirs;
    in
    {
      programs.vscode.profiles.default.languageSnippets = readSnippets snippetsDir;
    };
}
