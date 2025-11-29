{ inputs, ... }:
{
  flake-file.inputs.home-manager.url = "github:nix-community/home-manager";
  flake-file.inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";
  flake-file.inputs.nix-darwin.url = "github:nix-darwin/nix-darwin/master";
  flake-file.inputs.nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

  flake.nixosConfigurations.eveeifyeve = inputs.nix-darwin.lib.darwinSystem {
    system = "x86_64-linux";
    modules = with inputs.self.modules.nixos; [ ];
  };

  flake.darwinConfigurations.eveeifyeve = inputs.nix-darwin.lib.darwinSystem {
    system = "aarch64-darwin";
    modules = with inputs.self.modules.darwin; [
    ];
  };
}
