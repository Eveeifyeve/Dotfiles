{ lib, ... }:
{
  nixvim.modules.base =
    { pkgs, ... }:
    {
      plugins.lsp.servers = {
        nil_ls.enable = true;
        nil_ls.settings.formatting.command = [ ];
        nixd = {
          enable = true;
          cmd = [ "nixd" ];
          settings = {
            formatting.command = [ "${lib.getExe pkgs.nixfmt-rs}" ];
            nixpkgs.expr = "import <nixpkgs> { }";
            options =
              let
                getFlake = ''(builtins.getFlake "./.")'';
              in
              {
                nixvim.expr = "import <nixvim>";
                flake-parts.expr = "${getFlake}.debug.options";
                flake-parts2.expr = "${getFlake}.currentSystem.options";
                darwin.expr = "import <nix-darwin> { }";
                nixos.expr = "import <nixpkgs> { }";
              };
          };
        };
      };
    };
}
