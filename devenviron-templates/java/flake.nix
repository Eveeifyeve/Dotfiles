{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs =
    inputs@{ nixpkgs, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = nixpkgs.lib.systems.flakeExposed;
      perSystem =
        {
          pkgs,
          system,
          ...
        }:
        let
          jdk = pkgs.jdk8;
        in
        {
          _module.args.pkgs = import nixpkgs {
            inherit system;
            config.allowUnsupportedSystem = true;
          };
          devShells.default = pkgs.mkShell {
            nativeBuildInputs = with pkgs; [
              jdk
              (gradle.override {
                java = jdk;
              })
            ];

            JAVA_HOME = jdk.home;
          };
        };
    };
}
