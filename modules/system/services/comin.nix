{ inputs, lib, ... }:
let
  polyModule = pkgs: {
    enable = true;
    desktop.enable = lib.mkIf pkgs.stdenv.isLinux;
    remotes = [
      {
        name = "origin";
        url = "https://github.com/eveeifeyve/dotfiles.git";
        branches = {
          testing.name = "";
        };
      }
    ];
  };
in
{
  flake-file.inputs.comin = {
    url = "github:nlewo/comin";
    inputs.nixpkgs.follows = "nixpkgs";
    inputs.flake-compat.follows = "flake-compat";
  };

  nixos.modules.base =
    { pkgs, ... }:
    {
      imports = [ inputs.comin.nixosModules.comin ];
      services.comin = polyModule pkgs;
    };

  darwin.modules.base =
    { pkgs, ... }:
    {
      imports = [ inputs.comin.darwinModules.comin ];
      services.comin = polyModule pkgs;
    };
}
