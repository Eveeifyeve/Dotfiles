{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    systems.url = "github:nix-systems/default/future-26.11";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-compat = {
      url = "github:NixOS/flake-compat";
      flake = false;
    };
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = import inputs.systems;
      perSystem =
        {
          lib,
          pkgs,
          system,
          ...
        }:
        let
          toolchain = pkgs.rust-bin.stable.latest.default.override {
            extensions = [ "rust-src" ];
            targets = [
              "aarch64-apple-darwin"
              "x86_64-apple-darwin"

              # If building for iOS, add the following targets:
              # "aarch64-apple-ios"
              # "x86_64-apple-ios"
              # "aarch64-apple-ios-sim"

              # If building for Android, add the following targets:
              # "aarch64-linux-android"
              # "armv7-linux-androideabi"
              # "i686-linux-android"
              # "x86_64-linux-android"
            ];
          };

          # toolchain = rust-bin.fromRustupToolchainFile ./toolchain.toml; # Alternatively
        in
        {
          _module.args.pkgs = import inputs.nixpkgs {
            inherit system;
            overlays = [
              (import inputs.rust-overlay)
            ];
          };

          packages.default = pkgs.callPackage ./package.nix {
            rustPlatform = pkgs.makeRustPlatform {
              cargo = toolchain;
              rustc = toolchain;
            };
          };

          devShells.default = pkgs.mkShell {
            nativeBuildInputs = [
              pkgs.openssl
              pkgs.pkgs-config
              toolchain
            ]
            ++ lib.optionals pkgs.stdenv.isLinux [
              pkgs.webkitgtk_4_1
              pkgs.glib-networking
            ]
            ++ lib.optionals pkgs.stdenv.isDarwin [
              pkgs.apple_sdk
            ];
          };
        };
    };
}
