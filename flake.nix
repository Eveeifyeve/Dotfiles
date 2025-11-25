{
  description = "Eveeifyeve Nix/NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-old.url = "github:NixOS/nixpkgs/nixos-25.05";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    nix-darwin.url = "github:LnL7/nix-darwin";

    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins.url = "github:hyprwm/hyprland-plugins";
    hyprland-plugins.inputs.hyprland.follows = "hyprland";

    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    pre-commit-hooks.url = "github:cachix/git-hooks.nix";
    stylix.url = "github:nix-community/stylix/master";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    nixcord.url = "github:kaylorben/nixcord";

    eveeifyeve-flake-templates.url = "github:Eveeifyeve/flake-templates";

    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };

    deskflow-homebrew-tap = {
      url = "github:deskflow/homebrew-tap";
      flake = false;
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    compose.url = "github:digitalbrewstudios/nixos-compose";
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
            inputs.stylix.nixosModules.stylix
            ./hosts/eveeifyeve
            ./modules/vim
            ./modules/stylix.nix
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
                sharedModules = [
                  inputs.nixcord.homeModules.nixcord
                ];
              };
            }
          ];
        };
      };

      # Nix on Darwin with Nix-Darwin x HM
      darwinConfigurations = {
        eveeifyeve-macbook = inputs.nix-darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          specialArgs = {
            inherit inputs;
          }; # Inputs are needed for homebrew
          modules = [
            inputs.agenix.darwinModules.default
            inputs.nixvim.nixDarwinModules.nixvim
            inputs.nix-homebrew.darwinModules.nix-homebrew
            inputs.home-manager.darwinModules.home-manager
            inputs.stylix.darwinModules.stylix
            {
              home-manager = {
                extraSpecialArgs = {
                  git = {
                    username = "eveeifyeve";
                    email = "88671402+Eveeifyeve@users.noreply.github.com";
                  };
                  inherit inputs;

                  masterPkgs = import inputs.nixpkgs-master {
                    system = "aarch64-darwin";
                  };
                };
                useGlobalPkgs = true;
                useUserPackages = true;
                backupFileExtension = "backup";
                users.eveeifyeve = import ./hosts/eveeifyeve-mac/home.nix;
                sharedModules = [
                  inputs.nixcord.homeModules.nixcord
                  inputs.zen-browser.homeModules.beta
                ];
              };
            }
            ./hosts/eveeifyeve-mac
            ./modules/vim
            #TODO: wait for pr to come out https://github.com/nix-darwin/nix-darwin/pull/942
            #./modules/nix-darwin/nh.nix
            ./modules/nix-darwin/rice.nix
            ./modules/stylix.nix
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
