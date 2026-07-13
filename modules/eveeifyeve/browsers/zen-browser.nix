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
              liveFolders = {
                "Pull-Requests" = {
                  id = "e5b81c39-7f42-4d0a-96e3-2a8c50d17b64";
                  kind = "github:pull-requests";
                  position = 400;
                  github.reviewRequested = true;
                };
                "Issues" = {
                  id = "3c9e1f7a-5b24-4d80-9a6c-e2f4b8d10c57";
                  kind = "github:issues";
                  position = 402;
                  github.authorMe = true;
                };
              };
              container = 1;
            };
            "School" = {
              id = "4d9d5171-17b1-40af-806f-f8e2368917fe";
              position = 2000;
              container = 2;
              icon = "📚";
            };
            "Business" = {
              id = "c6b5915b-be12-44b4-9856-e1ff900187d6";
              position = 3000;
              container = 3;
              icon = "💼";
              liveFolders = {
                "Pull-Requests" = {
                  id = "a585dfd3-02d3-4ae7-8521-f2a37f23f85f";
                  kind = "github:pull-requests";
                  position = 400;
                  github.reviewRequested = true;
                };
                "Issues" = {
                  id = "482edb96-f1c7-49a4-8e31-b0aac1dd8a31";
                  kind = "github:issues";
                  position = 402;
                  github.reviewRequested = true;
                };
              };
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

          mods = [
            "642854b5-88b4-4c40-b256-e035532109df" # Transparent Zen
            "ad97bb70-0066-4e42-9b5f-173a5e42c6fc" # SuperPins
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
