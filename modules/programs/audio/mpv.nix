{
  homeManager.modules.base =
    { pkgs, ... }:
    {
      programs.mpv = {
        enable = true;
        scripts = with pkgs.mpvScripts; [
          mpv-discord
          modernz
        ];
      };
    };
}
