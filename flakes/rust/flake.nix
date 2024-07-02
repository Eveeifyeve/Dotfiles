{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    devenv.url = "github:cachix/devenv";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions"; # VSCode Instance
    fenix.url = "github:nix-community/fenix";
  };

  outputs =
    inputs@{ flake-parts, nixpkgs, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [ inputs.devenv.flakeModule ];
      systems = nixpkgs.lib.systems.flakeExposed;

      perSystem =
        {
          self',
          inputs',
          lib,
          pkgs,
          ...
        }:
        {
          devenv.shells.default = {
            difftastic.enable = true;
            packages =
              lib.optionals pkgs.stdenv.isDarwin (
                with pkgs.darwin.apple_sdk.frameworks;
                [
                  Security
                  SystemConfiguration
                ]
              )
              && [
                pkgs.vscode-with-extensions.override
                {
                  vscode = pkgs.vscodium;
                  vscodeExtensions = with pkgs.extensions; [ vscode-marketplace.rust-lang.rust-analyzer vscode-marketplace.dustypomerleau.rust-syntax vscode-marketplace.serayuzgur.crates ];
                }
              ];

            enterShell = ''
              printf "VSCodium with extensions:\n"
              codium --list-extensions
            '';

            languages.rust = {
              enable = true;
              channel = "stable"; # or "nightly"
            };

            dotenv = {
              enable = true;
              disableHint = true;
            };

            pre-commit.hooks = {
              nixfmt = {
                enable = true;
                package = pkgs.nixfmt-rfc-style;
              };
              clippy.enable = true;
            };
          };
        };
    };
}
