{
  description = "Eveeifyeve Nix/NixOS Configuration";

	inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
	inputs.nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
	inputs.nix-darwin.url = "github:LnL7/nix-darwin";

  inputs.nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  inputs.pre-commit-hooks.url = "github:cachix/git-hooks.nix";
  inputs.stylix.url = "github:danth/stylix";

	inputs.disko.url = "github:nix-community/disko";
	inputs.disko.inputs.nixpkgs.follows = "nixpkgs";
	inputs.hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
	
	inputs.nixvim.url = "github:nix-community/nixvim";
	inputs.nixvim.inputs.nixpkgs.follows = "nixpkgs";
	inputs.eveeifyeve-flake-templates.url = "github:Eveeifyeve/flake-templates";

	inputs.agenix.url = "github:ryantm/agenix";
	inputs.agenix.inputs.nixpkgs.follows = "nixpkgs";

	inputs.home-manager = {
    url = "github:nix-community/home-manager";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  inputs.hyprland-plugins = {
    url = "github:hyprwm/hyprland-plugins";
    inputs.hyprland.follows = "hyprland";
  };

  inputs.homebrew-core = {
    url = "github:homebrew/homebrew-core";
    flake = false;
  };
  inputs.homebrew-cask = {
    url = "github:homebrew/homebrew-cask";
    flake = false;
  };
  inputs.homebrew-bundle = {
    url = "github:homebrew/homebrew-bundle";
    flake = false;
  };
  inputs.homebrew-cask-versions = {
    url = "github:homebrew/homebrew-cask-versions";
    flake = false;
  };

  outputs =
    inputs@{ self, nixpkgs, ... }:
    let
      forAllSystems =
        f:
        nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed (
          system:
          f {
            pkgs = import nixpkgs { inherit system; };
            inherit system;
          }
        );
    in
    {
      formatter = forAllSystems ({ pkgs, system }: pkgs.nixfmt-rfc-style);

      checks = forAllSystems (
        { pkgs, system }:
        {
          pre-commit-check = inputs.pre-commit-hooks.lib.${system}.run {
            src = ./.;
            hooks = {
              nixfmt-rfc-style.enable = true;
            };
          };
        }
      );

      # NixOS
      nixosConfigurations = {
        eveeifyeve = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs;
          };
          modules = [
            inputs.disko.nixosModules.disko
            inputs.nixvim.nixosModules.nixvim
            inputs.agenix.nixosModules.default
            ./hosts/eveeifyeve
            ./modules/vim
            inputs.home-manager.nixosModules.home-manager
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
            inputs.agenix.darwinModules.default
            inputs.nixvim.nixDarwinModules.nixvim
            inputs.nix-homebrew.darwinModules.nix-homebrew
            inputs.home-manager.darwinModules.home-manager
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
            # ./modules/nix-darwin/nh.nix
            ./modules/homebrew.nix
          ];
        };
      };

      devShells = forAllSystems (
        { pkgs, system }:
        {
          default = pkgs.mkShell {
            inherit (self.checks.${system}.pre-commit-check) shellHook;
            buildInputs = self.checks.${system}.pre-commit-check.enabledPackages;
          };
        }
      );

      # Nix Flake Templates for Shell Environments
      # https://github.com/Eveeifyeve/flake-templates
      templates = inputs.eveeifyeve-flake-templates.templates;
    };
}
