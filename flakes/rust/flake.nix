{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    devenv.url = "github:cachix/devenv";
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
              );

            languages.rust = {
              enable = true;
              channel = "stable"; # or "nightly"
            };

            dotenv = {
              enable = true;
              disableHint = true;
            };
          };
        };
    };
}
