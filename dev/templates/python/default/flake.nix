{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      flake-parts,
      ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = nixpkgs.lib.systems.flakeExposed;
      perSystem =
        {
          pkgs,
          config,
          lib,
          ...
        }:
        {
          devShells.default = pkgs.mkShell {
            packages = with pkgs; [
              (python3.withPackages (
                p: with p; [
                  # Python dependencies
                ]
              ))
            ];
          };
        };
    };
}
