{
  description = "Project Description"; #TODO: Project Description

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

  outputs = inputs@{ flake-parts, nixpkgs, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        inputs.devenv.flakeModule
      ];
      systems = [ "x86_64-linux" "i686-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin" ];

      perSystem = { config, self', inputs', lib, pkgs, system, ... }:
        let
          cargoBuildInputs = lib.optionals pkgs.stdenv.isDarwin (with pkgs.darwin.apple_sdk; [
            frameworks.Security
            frameworks.CoreServices
          ]);
        in {
        devenv.shells.default = {
          name = "Project Name"; #TODO: Change Project Name
          difftastic.enable = true;
          imports = [];

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
          languages.rust = {
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

          # https://devenv.sh/pre-commit-hooks/
          pre-commit.hooks = {
            nixfmt.package = pkgs.nixfmt-rfc-style;
            nixfmt.enable = true;
            clippy.enable = true;
            yamllint.enable = true;
          };

          # https://devenv.sh/integrations/dotenv/
          dotenv.enable = true;
        };

      };
      flake = {
      };
    };
}