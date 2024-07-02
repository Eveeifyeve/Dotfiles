{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    devenv.url = "github:cachix/devenv";
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      flake-parts,
      nixpkgs,
      nix-vscode-extensions,
      ...
    }:
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
        let
          extensions = inputs.nix-vscode-extensions.extensions.${system};
          inherit (pkgs) vscode-with-extensions vscodium;
        in
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
              ++ [
                (vscode-with-extensions.override {
                  vscode = vscodium;
                  vscodeExtensions = with extensions; [
                    vscode-marketplace.rust-lang.rust-analyzer
                    vscode-marketplace.dustypomerleau.rust-syntax
                    vscode-marketplace.serayuzgur.crates
                  ];
                })
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
