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
          config,
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
              inherit (pkgs.darwin.apple_sdk.frameworks) ; # Required Frameworks needed for macOS

              # Rust Toolchain
              toolchain = pkgs.rust-bin.stable.latest.default.override {
                extensions = [ "rust-src" ];
                targets = [ "x86_64-unknown-linux-gnu" ];
              };

              # toolchain = rust-bin.fromRustupToolchainFile ./toolchain.toml; # Alternatively
            in
            mkShell {
              nativeBuildInputs =
                with pkgs;
                [
                  toolchain
                ]
                ++ lib.optionals stdenv.isLinux [
                  openssl
                  # Additional Dependencies here for Linux.
                ]
                ++ lib.optionals stdenv.isDarwin [
                  # Frameworks here
                ];
            };
        };
    };
}
