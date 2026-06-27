{
  nixpkgs.config.allowUnfreePackages = [ "tampermonkey" ];
  home.gui =
    { pkgs, ... }:
    {
      programs.zen-browser = {
        profiles.default = {
          containersForce = true;
          spacesForce = true;
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

          extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
            darkreader
            zen-internet
            ublock-origin
            indie-wiki-buddy
            vimium
            refined-github
            youtube-nonstop
            return-youtube-dislikes
            tampermonkey
          ];
        };

        policies."3rdparty".Extensions."firefox@tampermonkey.net".jsonImport = [
          {
            hash = "1:66849534c66c5bd384f39f7fb5c7c5bdbc8611bfedab082762cb943f853637d0";
            url = "https://raw.githubusercontent.com/Eveeifyeve/nixpkgs-review-gha/refs/heads/main/shortcut.user.js";
            installAsSystemScripts = true;
          }
        ];
      };
    };
}
