{ inputs, ... }:
{
  flake-file.inputs.nixpkgs-kotlin-lsp.url = "github:bew/nixpkgs/init-kotlin-lsp";

  nixvim.modules.base =
    { pkgs, ... }:
    let
      pkgs-kotlin-lsp = import inputs.nixpkgs-kotlin-lsp {
        inherit (pkgs.stdenv) system;
        config.allowUnfree = true;
      };
    in
    {
      plugins.lsp.servers.kotlin_language_server = {
        enable = true;
        package = pkgs-kotlin-lsp.kotlin-lsp;
      };
    };
}
