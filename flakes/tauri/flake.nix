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
            packages = lib.optionals pkgs.stdenv.isDarwin (
              with pkgs;
              [
                darwin.apple_sdk.frameworks.Security
                darwin.apple_sdk.frameworks.SystemConfiguration
                darwin.apple_sdk.frameworks.AppKit
                darwin.apple_sdk.frameworks.WebKit
                llvmPackages.libcxxStdenv
                llvmPackages.libcxxClang
                darwin.libobjc
                rustup
              ]
            );
            languages = {
              rust = {
                enable = true;
                channel = "stable";
                components = [
                  "rustc"
                  "cargo"
                  "clippy"
                  "rustfmt"
                  "rust-analyzer"
                ];
              };
              javascript = {
                enable = true;
                # Enable your Favourite Package Manager via here.
                # bun = {
                #   enable = true;
                #   install.enable = true;
                # };
              };
              typescript = {
                enable = true;
              };
            };
            dotenv.enable = true;
          };
        };
    };
}
