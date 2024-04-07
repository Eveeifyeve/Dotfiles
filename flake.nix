{
  description = "Eveeifyeve Nix/NixOS Configuration";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
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

  outputs = inputs@{self, nixpkgs, home-manager, nix-darwin, nix-homebrew, homebrew-core, homebrew-cask, homebrew-cask-versions, ... }: {
    # Macos Config
    darwinConfigurations = {
      "eveeifyeve-macbook" = let 
      username = "eveeifyeve";
      in
      nix-darwin.lib.darwinSystem {
        specialArgs = { inherit username homebrew-cask homebrew-cask-versions homebrew-core; };
        modules = [
          ./hosts/macos/darwin.nix
          home-manager.darwinModules.home-manager
          {
            users.users.${username} = {
              name = username;
              home = "/Users/${username}";
            };
            home-manager = {
             useGlobalPkgs = true;
             useUserPackages = true;
             users."${username}" = {
             home.username = username;
             home.homeDirectory = "/Users/${username}";
             imports = [./hosts/macos/home.nix];
              };
            };
          }
          nix-homebrew.darwinModules.nix-homebrew {
            imports = [./modules/homebrew.nix]; 
          }
        ];
      };
    };


    templates = {
      node = {
        path = ./flakes/node;
        description = "NodeJS development environment";
      };
      rust = {
        path = ./flakes/rust;
        description = "Rust development environment";
      };
    };
  };
}
