{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ nixpkgs, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = nixpkgs.lib.systems.flakeExposed;
      perSystem =
        {
          lib,
          pkgs,
          system,
          ...
        }:
        {
          _module.args.pkgs = import nixpkgs {
            inherit system;
            overlays = [
              (import inputs.rust-overlay)
            ];
          };

          devShells.default =
            with pkgs;
            let
              # Rust Toolchain
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
            mkShell {
              nativeBuildInputs =
                with pkgs;
                [
                  openssl
                  pkgs-config
                  toolchain
                ]
                ++ lib.optionals stdenv.isLinux [
                  webkitgtk_4_1
                  glib-networking
                ]
                ++ lib.optionals stdenv.isDarwin [
                  apple_sdk
                ];
            };
        };
    };
}
