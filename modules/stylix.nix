{ pkgs, lib, config, ... }:
let
  themes = {
    catppucin = {
      base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
      cursor = {
        name = "BreezeX-RosePine-Linux";
        package = pkgs.rose-pine-cursor;
      };
     # wallpapers = {
     #   byrotek = pkgs.fetchurl {
     #     url = "https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/80a9d98d-327f-4bb2-b173-4298d710e51c/derkflv-9f975f3d-791f-4e16-8d9d-fb0a9e5e0554.png?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7InBhdGgiOiJcL2ZcLzgwYTlkOThkLTMyN2YtNGJiMi1iMTczLTQyOThkNzEwZTUxY1wvZGVya2Zsdi05Zjk3NWYzZC03OTFmLTRlMTYtOGQ5ZC1mYjBhOWU1ZTA1NTQucG5nIn1dXSwiYXVkIjpbInVybjpzZXJ2aWNlOmZpbGUuZG93bmxvYWQiXX0.eEDVAlJGBqXo6OeZEORXWk1veGSHFL-ZTUMz43Jtr3Q";
     #     hash = "sha256-TFEFcNwgz05UrPfCNxNTIobYAIjUrZzR5JY83VZYwPE=";
     #   };
     #   louis_coyle = pkgs.fetchurl {
     #     url = "https://cdn.dribbble.com/users/13449/screenshots/12078823/downloads/the_valley.png";
     #     hash = lib.fakeHash;
     #   };
     # };
    };
    #TODO: Add more themes here
  };
in
{
  stylix = 
	{
    enable = true;
    autoEnable = true;
    polarity = "dark";
    image = config.lib.stylix.pixel "base0A";
    inherit (themes.catppucin) cursor base16Scheme;
  };
}
