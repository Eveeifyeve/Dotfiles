{
  description = "Eveeifyeve Nix/NixOS Configuration";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    eveeifyeve-flake-templates = {
      url = "github:Eveeifyeve/flake-templates";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Vim
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Secrets
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Home Brew
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };
    homebrew-cask-versions = {
      url = "github:homebrew/homebrew-cask-versions";
      flake = false;
    };
    curseforge-nix = {
      url = "github:eveeifyeve/curseforge-nix";
      flake = false;
    };
  };

  outputs =
    inputs@{ self, ... }:
    let
      username = "eveeifyeve";
      hostPlatform = "aarch64-darwin";
    in
    {
      formatter.${hostPlatform} = inputs.nixpkgs.legacyPackages.${hostPlatform}.nixfmt-rfc-style;
      # Nix on Darwin with Nix-Darwin x HM
      darwinConfigurations = {
        eveeifyeve-macbook = inputs.nix-darwin.lib.darwinSystem {
          specialArgs = {
            inherit username hostPlatform;
            inherit (inputs)
              homebrew-cask
              homebrew-cask-versions
              homebrew-core
              ;
          };
          modules = [
            inputs.agenix.darwinModules.default
            inputs.home-manager.darwinModules.home-manager
            {
              home-manager = {
                extraSpecialArgs = {
                  inherit username;
                };
                useGlobalPkgs = true;
                useUserPackages = true;
                users.${username}.imports = [ ./hosts/macos/home.nix ];
                modules = []
              };
            }
            inputs.nixvim.nixDarwinModules.nixvim
            {
              programs.nixvim.enable = true;
              imports = [
                ./modules/vim
                ./modules/vim/lsp.nix
                ./modules/vim/obsidian.nix
                ./modules/vim/settings.nix
              ];
            }
            inputs.nix-homebrew.darwinModules.nix-homebrew
            {
              nix-homebrew = {
                user = username;
                enable = true;
                enableRosetta = true;
                taps = {
                  "homebrew/homebrew-core" = inputs.homebrew-core;
                  "homebrew/homebrew-cask" = inputs.homebrew-cask;
                  "homebrew/bundle" = inputs.homebrew-bundle;
                  "homebrew/homebrew-cask-versions" = inputs.homebrew-cask-versions;
                };
                mutableTaps = false;
                autoMigrate = false;
              };
            }
            ./hosts/macos/darwin.nix
          ];
        };
      };

      # Nix Flake Templates for Shell Environments
      # https://github.com/Eveeifyeve/flake-templates
      templates = inputs.eveeifyeve-flake-templates.templates;
    };
}
