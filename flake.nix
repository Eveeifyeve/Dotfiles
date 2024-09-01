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
    inputs@{ self, agenix, home-manager, nix-homebrew, nixvim, nixpkgs, ... }:
    let
    pkgs = nixpkgs.pkgs;
    in
    {
      formatter = pkgs.nixfmt-rfc-style;
      # Nix on Darwin with Nix-Darwin x HM
      darwinConfigurations = {
        eveeifyeve-macbook = inputs.nix-darwin.lib.darwinSystem {
          # system = "aarch64-darwin";
          modules = [
            agenix.darwinModules.default
            nixvim.nixDarwinModules.nixvim
            nix-homebrew.darwinModules.nix-homebrew
            home-manager.darwinModules.home-manager
            {
              home-manager = 
              {
                useGlobalPkgs = true;
                useUserPackages = true;
                users."eveeifyeve".imports = [ ./hosts/macos/home.nix ];
              };
            }
            # nixpkgs {
            #   overlays = [
            #     inputs.curseforge-nix.overlay
            #   ];
            # }
            ./hosts/macos/darwin.nix
            ./modules/vim/default.nix
            ./modules/homebrew.nix { inherit inputs; } # Inputs are needed for homebrew
          ];
        };
      };

      # Nix Flake Templates for Shell Environments
      # https://github.com/Eveeifyeve/flake-templates
      templates = inputs.eveeifyeve-flake-templates.templates;
    };
}
