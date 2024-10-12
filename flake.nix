{
  description = "Eveeifyeve Nix/NixOS Configuration";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    pre-commit-hooks.url = "github:cachix/git-hooks.nix";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # HyprLand 
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
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
    inputs@{ self
    , agenix
    , home-manager
    , nix-homebrew
    , nixvim
    , nixpkgs
    , disko
    , ...
    }:
    let
      forAllSystems = nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed;
    in
    {
      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt-rfc-style);

      checks = forAllSystems (system: {
        pre-commit-check = inputs.pre-commit-hooks.lib.${system}.run {
          src = ./.;
          hooks = {
            nixpkgs-fmt.enable = true;
          };
        };
      });

      # NixOS
      nixosConfigurations = {
        eveeifyeve = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs;
          };
          modules = [
            disko.nixosModules.disko
            nixvim.nixosModules.nixvim
            ./hosts/eveeifyeve
            ./modules/vim
            home-manager.nixosModules.home-manager
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
                backupFileExtension = "backup";
                users.eveeifyeve = import ./hosts/eveeifyeve/home.nix;
              };
            }
          ];
        };
      };

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
            ./hosts/eveeifyeve-mac
            ./modules/vim
            ./modules/homebrew.nix
          ];
        };
      };

      devShells = forAllSystems (system: {
        default = nixpkgs.legacyPackages.${system}.mkShell {
          inherit (self.checks.${system}.pre-commit-check) shellHook;
          buildInputs = self.checks.${system}.pre-commit-check.enabledPackages;
        };
      });

      # Nix Flake Templates for Shell Environments
      # https://github.com/Eveeifyeve/flake-templates
      templates = inputs.eveeifyeve-flake-templates.templates;
    };
}
