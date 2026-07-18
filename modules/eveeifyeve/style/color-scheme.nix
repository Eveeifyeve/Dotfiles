{
  home.gui =
    { pkgs, ... }:
    {
      stylix = {
        base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
        polarity = "dark";
      };
    };
}
