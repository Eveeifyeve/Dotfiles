{ inputs, ... }:
{
  flake-file.inputs.nixcord = {
    url = "github:kaylorben/nixcord";
    inputs.nixpkgs-nixcord.follows = "nixpkgs";
  };

  homeManager.modules.gui =
    { pkgs, ... }:
    {
      imports = [
        inputs.nixcord.homeModules.nixcord
      ];

      programs.nixcord = {
        enable = true;
        discord.enable = false; # Disable other discords and only use vesktop (Darwin) & Equibop (Linux)
        vesktop = {
          enable = pkgs.stdenv.isDarwin;
          settings.arRPC = true;
        };
        equibop = {
          enable = pkgs.stdenv.isLinux;
          settings.arRPC = true;
        };
      };
    };
}
