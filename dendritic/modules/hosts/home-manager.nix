{
  flake.modules.nixos.home-manager = {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "backup";
    };
  };

  flake.modules.darwin.home-manager = {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "backup";
    };
  };

  # flake.modules.homeManager.home-manager = {
  # };
}
