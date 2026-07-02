{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    systems.url = "github:nix-systems/default/future-26.11";
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
          pkgs,
          ...
        }:
        let
          jdk = pkgs.jdk8;
        in
        {
          devShells.default = pkgs.mkShell {
            nativeBuildInputs = [
              jdk
              (pkgs.gradle.override {
                java = jdk;
              })
            ];

            JAVA_HOME = jdk.home;
          };
        };
    };
}
