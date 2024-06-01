{
  description = "Eveeifyeve Nix/NixOS Configuration";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/master";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    homebrew-cask-versions = {
      url = "github:homebrew/homebrew-cask-versions";
      flake = false;
    };
  };

  outputs =
    inputs@{ self, ... }:
    let
      username = "eveeifyeve";
      email = "eveeg1971@gmail.com";
      hostPlatform = "aarch64-darwin";
    in
    {
      formatter.${hostPlatform} = inputs.nixpkgs.legacyPackages.${hostPlatform}.nixfmt-rfc-style;

      # Nix on Darwin with Nix-Darwin x HM
      darwinConfigurations = {
        "eveeifyeve-macbook" = inputs.nix-darwin.lib.darwinSystem {
          specialArgs = {
            inherit username hostPlatform;
            inherit (inputs) homebrew-cask homebrew-cask-versions homebrew-core;
          };
          modules = [
            ./hosts/macos/darwin.nix
            inputs.home-manager.darwinModules.home-manager
            {
              home-manager = {
                extraSpecialArgs = {
                  inherit email username;
                };
                useGlobalPkgs = true;
                useUserPackages = true;
                users."${username}".imports = [ ./hosts/macos/home.nix ];
              };
            }
            inputs.nix-homebrew.darwinModules.nix-homebrew
            { imports = [ ./modules/homebrew.nix ]; }
            inputs.nixvim.nixDarwinModules.nixvim
            {
              programs.nixvim.enable = true;
              imports = [ ./modules/vim/plugs.nix ];
            }
          ];
        };
      };

      # Nix Flake Templates
      templates = {
        node = {
          path = ./flakes/node;
          description = "Template for setting up a Node.js project";
        };
        rust = {
          path = ./flakes/rust;
          description = "Template for setting up a Rust project";
        };
        java = {
          path = ./flakes/java;
          description = "Template for setting up a Java project";
        };
        python = {
          path = ./flakes/python;
          description = "Template for setting up a Python project";
        };
        tauri = {
          path = ./flakes/tauri;
          description = "Template for setting up a Tauri project";
        };
        kotlin = {
          path = ./flakes/kotlin;
          description = "Template for setting up a Kotlin project";
        };
      };
    };
}
