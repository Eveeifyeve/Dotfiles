{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    devenv.url = "github:cachix/devenv";
  };
  outputs =
    inputs@{ flake-parts, nixpkgs, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [ inputs.devenv.flakeModule ];
      systems = nixpkgs.lib.systems.flakeExposed;
      perSystem =
        {
          config,
          self',
          inputs',
          lib,
          pkgs,
          system,
          ...
        }:
        {
          devenv.shells.default = {
            difftastic.enable = true;
            packages =
              with pkgs;
              [ ]
              ++ (with pkgs.nodePackages; [
                vscode-langservers-extracted
                typescript-language-server
              ]);
            languages.javascript = {
              enable = true;
              bun = {
                enable = true;
                install.enable = true;
              };
              pnpm = {
                enable = false;
                install.enable = false;
              };
            };

            languages.typescript = {
              enable = true;
            };
            dotenv.enable = true;
          };
        };
    };
}
