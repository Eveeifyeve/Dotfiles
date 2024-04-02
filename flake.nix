{
  description = "Eveeifyeve Nix/NixOS Configuration";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{self, nixpkgs, home-manager, nix-darwin, ... }: {
    # Macos Config
    darwinConfigurations = {
      "eveeifyeve-macbook" = let 
      username = "eveeifyeve";
      in
      nix-darwin.lib.darwinSystem {
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
        ];
      };
    };
  };
}
