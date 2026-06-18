{
  homeManager.modules.base =
    { pkgs, ... }:
    {
      programs.gh = {
        enable = true;
        settings = {
          git_protocol = "ssh";
          prompt = "enabled";

          aliases = {
            co = "pr checkout";
            pv = "pr view";
          };
        };
      };

      home.packages = [ pkgs.gh-dash ];
    };
}
