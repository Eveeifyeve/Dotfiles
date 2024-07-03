{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    devenv.url = "github:cachix/devenv";
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
            packages = with pkgs; [];
            languages.java = {
              enable = true;
              jdk.package = pkgs.jdk8; # Java Version/Package
              gradle.enable = true; # Disable if not using gradle
              maven.enable = false; # Disable if not using maven
            };
            dotenv.enable = true;
          };
        };
    };
}
