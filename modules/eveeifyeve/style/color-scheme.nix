{
  home.gui =
    { pkgs, ... }:
    {
      stylix = {
        base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";
        polarity = "dark";
      };
    };
}
