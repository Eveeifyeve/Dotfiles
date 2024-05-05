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
      nixpkgs,
      home-manager,
      nix-darwin,
      nix-homebrew,
      nixvim,
      homebrew-core,
      homebrew-cask,
      homebrew-cask-versions,
      ...
    }:
    {
      # Macos Config
      darwinConfigurations = {
        "eveeifyeve-macbook" =
          let
            username = "eveeifyeve";
          in
          nix-darwin.lib.darwinSystem {
            specialArgs = {
              inherit
                username
                homebrew-cask
                homebrew-cask-versions
                homebrew-core
                ;
            };
            modules = [
              ./hosts/macos/darwin.nix
              home-manager.darwinModules.home-manager
              {
                users.users.${username} = {
                  name = username;
                  home = "/Users/${username}";
                };
                home-manager = {
                  # Uses the global pkgs and user packages
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  users."${username}" = {
                    # Home Manager needs a bit of information to make HM work.
                    home.username = username;
                    home.stateVersion = "22.05";
                    home.homeDirectory = "/Users/${username}";
                    programs.home-manager.enable = true;
                    imports = [ ./hosts/macos/home.nix ];
                    nix.settings = {
                      experimental-features = [
                        "nix-command"
                        "flakes"
                      ];
                      allowed-users = [
                        "eveeifyeve"
                        "root"
                      ];
                      warn-dirty = false;
                    };
                  };
                };
              }
              nix-homebrew.darwinModules.nix-homebrew
              # Nix-Homebrew Configured in ./modules/homebrew.nix
              { imports = [ ./modules/homebrew.nix ]; }
              nixvim.nixDarwinModules.nixvim
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
