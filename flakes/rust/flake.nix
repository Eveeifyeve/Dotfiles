{
  description = "Node-Project Flake";

  inputs = {
    nixpkgs.url = "github:cachix/devenv-nixpkgs/rolling";
    devenv.url = "github:cachix/devenv";
    nix2container.url = "github:nlewo/nix2container";
    nix2container.inputs.nixpkgs.follows = "nixpkgs";
    mk-shell-bin.url = "github:rrbutani/nix-mk-shell-bin";
  };

  nixConfig = {
    extra-trusted-public-keys = "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=";
    extra-substituters = "https://devenv.cachix.org";
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        inputs.devenv.flakeModule
      ];
      systems = [ "x86_64-linux" "i686-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin" ];
      perSystem = { config, self', inputs', pkgs, system, ... }: {
      packages.devenv-up = self'.devShells.default.config.procfileScript;

        devenv.shells.default = {
          name = "Node-Project";

          # https://devenv.sh/guides/using-with-flake-parts/#import-a-devenv-module
          imports = [
          ];

          # https://devenv.sh/reference/options/
          packages = [ 
            config.packages.default 
            languages.rust {
              enable = true;
              channel = "stable"; # Your Rust Channel Deafult Is Stable
              rust.components = ["rustc" "cargo" "clippy" "rustfmt" "rust-analyzer"]; # Tools
            }
          ];
        };

      };
      flake = {
        # The usual flake attributes can be defined here, including system-
        # agnostic ones like nixosModule and system-enumerating ones, although
        # those are more easily expressed in perSystem.

      };
    };
}
