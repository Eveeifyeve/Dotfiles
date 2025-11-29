{ inputs, ... }:
{
  flake-file.inputs.home-manager.url = "github:nix-community/home-manager";
  flake-file.inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";
  flake-file.inputs.nix-darwin.url = "github:nix-darwin/nix-darwin/master";
  flake-file.inputs.nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

  imports = [
    inputs.home-manager.flakeModules.home-manager
  ];

  flake.nixosConfigurations.eveeifyeve = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = with inputs.self.modules.nixos; [
      state-version
      home-manager
      stylix
      {
        home-manager.users.eveeifyeve = {
          home.username = "eveeifyeve";
          home.homeDirectory = "/home/eveeifyeve";
          imports = with inputs.self.homeModules; [
            discord
            state-version
          ];
        };
      }
    ];
  };

  flake.darwinConfigurations.eveeifyeve = inputs.nix-darwin.lib.darwinSystem {
    system = "aarch64-darwin";
    modules = with inputs.self.modules.darwin; [
      state-version
      home-manager
      stylix
      {
        home-manager.users.eveeifyeve = {
          home.username = "eveeifyeve";
          home.homeDirectory = "/home/eveeifyeve";
          imports = with inputs.self.homeModules; [
            discord
            state-version
          ];
        };
      }
    ];
  };
}
