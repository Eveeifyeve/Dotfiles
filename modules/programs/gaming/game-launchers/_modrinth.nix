{
  nixpkgs.config.allowUnfreePackages = [
    "modrinth-app-unwrapped"
    "modrinth-app"
  ];

  homeManager.modules.gui =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.modrinth-app
      ];
    };
}
