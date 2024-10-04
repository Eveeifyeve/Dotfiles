{
  description = "Eveeifyeve Nix/NixOS Configuration";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Eveeifyeve Usefull Resources.
    curseforge-nix = {
      url = "github:eveeifyeve/curseforge-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    eveeifyeve-flake-templates = {
      url = "github:Eveeifyeve/flake-templates";
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
  };

  outputs =
    inputs@{
      self,
      agenix,
      home-manager,
      nix-homebrew,
      nixvim,
      nixpkgs,
      ...
    }:
    {
      formatter.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.nixfmt-rfc-style;

      # Nix on Darwin with Nix-Darwin x HM
      darwinConfigurations = {
        eveeifyeve-macbook = inputs.nix-darwin.lib.darwinSystem {
          # system = "aarch64-darwin";
          specialArgs = {
            inherit inputs;
          }; # Inputs are needed for homebrew
          modules = [
            agenix.darwinModules.default
            nixvim.nixDarwinModules.nixvim
            nix-homebrew.darwinModules.nix-homebrew
            home-manager.darwinModules.home-manager
            {
              home-manager = {
                extraSpecialArgs = {
                  git = {
                    username = "eveeifyeve";
                    email = "88671402+Eveeifyeve@users.noreply.github.com";
                  };
									inherit inputs;
                };
                useGlobalPkgs = true;
                useUserPackages = true;
                users.eveeifyeve = import ./hosts/eveeifyeve-mac/home.nix;
              };
            }
            ./hosts/eveeifyeve-mac/darwin.nix
            ./modules/vim/default.nix
            ./modules/homebrew.nix
          ];
        };
      };

      # Nix Flake Templates for Shell Environments
      # https://github.com/Eveeifyeve/flake-templates
      templates = inputs.eveeifyeve-flake-templates.templates;
    };
}
