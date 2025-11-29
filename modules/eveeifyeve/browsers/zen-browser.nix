{ inputs, ... }:
{
  flake-file.inputs.firefox-addons = {
    url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  home.gui =
    { pkgs, ... }:
    {
      programs.zen-browser.profiles.default = {
        extensions.packages = with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
          darkreader
          zen-internet
          ublock-origin
          indie-wiki-buddy
          vimium
          refined-github
          youtube-nonstop
          return-youtube-dislikes
          violentmonkey
        ];
        containersForce = true;
        containers = {
          Personal = {
            color = "blue";
            icon = "fingerprint";
            id = 1;
          };
          School = {
            color = "green";
            icon = "briefcase";
            id = 2;
          };
        };
        spacesForce = true;
        spaces = {
          "Personal" = {
            id = "6c0667d1-cef1-4fff-897f-2b5ca5073574";
            container = 1;
          };
          "School" = {
            id = "4d9d5171-17b1-40af-806f-f8e2368917fe";
            position = 2000;
            container = 2;
            icon = "📚";
          };
        };
        search = {
          force = true;
          default = "unduck";
          engines = {
            unduck = {
              name = "unduck";
              definedAliases = [ "@unduck" ];
              urls = {
                template = "https://s.dunkirk.sh?q={searchTerms}";
                params = [
                  {
                    name = "query";
                    value = "searchTerms";
                  }
                ];
              };
            };
          };
        };
      };
    };
}
