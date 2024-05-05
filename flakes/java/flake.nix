{
  description = "Project Description"; # TODO: Project Description

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    devenv.url = "github:cachix/devenv";
    nix2container.url = "github:nlewo/nix2container";
    nix2container.inputs.nixpkgs.follows = "nixpkgs";
    mk-shell-bin.url = "github:rrbutani/nix-mk-shell-bin";
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  nixConfig = {
    extra-trusted-public-keys = "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=";
    extra-substituters = "https://devenv.cachix.org";
  };

  outputs =
    inputs@{ flake-parts, nixpkgs, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [ inputs.devenv.flakeModule ];
      systems = [
        "x86_64-linux"
        "i686-linux"
        "aarch64-linux"
      ];

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
            name = "Project Name"; # TODO: Change Project Name
            difftastic.enable = true;
            imports = [ ];

            # https://devenv.sh/reference/options/
            packages = with pkgs; [

            ];

            # Define Enviroment Virables
            env = {

            };

            # https://devenv.sh/scripts/
            # scripts.hello.exec = "";

            # enterShell = ''

            # '';

            # https://devenv.sh/languages/
            languages.java = {
              enable = true;
              jdk.package = pkgs.jdk8; # Java Version/Package
              gradle.enable = true; # Disable if not using gradle
              maven.enable = false; # Disable if not using maven
            };

            # https://devenv.sh/pre-commit-hooks/
            pre-commit.hooks = {
              nixfmt.package = pkgs.nixfmt-rfc-style;
              nixfmt.enable = true;
              clippy.enable = true;
            };

            # https://devenv.sh/integrations/dotenv/
            dotenv.enable = true;
          };
        };
      flake = { };
    };
}
