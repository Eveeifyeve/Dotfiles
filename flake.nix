{
  description = "Eveeifyeve Nix/NixOS Configuration";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
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
    inputs@{
      self,
      ...
    }:
    {
      # Macos Config
      darwinConfigurations = {
        "eveeifyeve-macbook" =
          let
            username = "eveeifyeve";
            email = "eveeg1971@gmail.com";
          in
          inputs.nix-darwin.lib.darwinSystem {
            specialArgs = {
              inherit username;
              inherit (inputs) 
                homebrew-cask
                homebrew-cask-versions
                homebrew-core
              ;
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
              { imports = [ ./modules/nixvim.nix ]; }
            ];
          };
      };

      # Nix Flake Templates
      templates = {
        node.path = ./flakes/node;
        rust.path = ./flakes/rust;
        java.path = ./flakes/java;
        python.path = ./flakes/python;
        tauri.path = ./flakes/tauri;
        kotlin.path = ./flakes/kotlin;
      };
    };
}
