{
  description = "Eveeifyeve Nix/NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    systems.url = "github:nix-systems/default";

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    # nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    # nix-darwin.url = "github:LnL7/nix-darwin";
    #
    # hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    # hyprland-plugins.url = "github:hyprwm/hyprland-plugins";
    # hyprland-plugins.inputs.hyprland.follows = "hyprland";
    #
    # nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    # stylix.url = "github:Eveeifyeve/stylix/jankyborders/init";
    #
    # disko.url = "github:nix-community/disko";
    # disko.inputs.nixpkgs.follows = "nixpkgs";
    #
    # nixvim.url = "github:nix-community/nixvim";
    # nixvim.inputs.nixpkgs.follows = "nixpkgs";
    #
    # nixcord.url = "github:kaylorben/nixcord";
    #
    # eveeifyeve-flake-templates.url = "github:Eveeifyeve/flake-templates";
    #
    # agenix.url = "github:ryantm/agenix";
    # agenix.inputs.nixpkgs.follows = "nixpkgs";
    #
    # home-manager.url = "github:nix-community/home-manager";
    # home-manager.inputs.nixpkgs.follows = "nixpkgs";
    #
    # homebrew-core = {
    #   url = "github:homebrew/homebrew-core";
    #   flake = false;
    # };
    # homebrew-cask = {
    #   url = "github:homebrew/homebrew-cask";
    #   flake = false;
    # };
    # homebrew-bundle = {
    #   url = "github:homebrew/homebrew-bundle";
    #   flake = false;
    # };
    # homebrew-cask-versions = {
    #   url = "github:homebrew/homebrew-cask-versions";
    #   flake = false;
    # };
  };
  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = inputs.nixpkgs.lib.systems.flakeExposed;
      imports = [
        inputs.flake-parts.flakeModules.partitions
      ];
      partitions = {
        dev = {
          module = ./dev;
          extraInputsFlake = ./dev;
        };
      };
      partitionedAttrs = {
        checks = "dev";
        devShells = "dev";
        formatter = "dev";
        templates = "dev";
      };
    };
}
