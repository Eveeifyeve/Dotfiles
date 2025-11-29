{ config, ... }:
{
  home.base = {
    programs.git.settings.user = { inherit (config.users.eveeifyeve) name email; };
  };

  homeManager.modules.base = {
    programs.git = {
      enable = true;
      settings = {
        credential.helper = "store";
        push.autoSetupRemote = true;

        aliases = {
          st = "status -s";
          sta = "status";
          ci = "commit";
          co = "checkout";
          cod = "checkout .";
          rh = "reset HEAD";
          aa = "add -A";
          cdf = "clean -df";
          pr = "pull --rebase";
          br = "branch";
          bra = "branch -a";
          amend = "commit -a --amend --no-edit";
          ciam = "commit -a --amend --no-edit";

          ei = "add --intent-to-add";
          eu = "update-index --assume-unchanged";
          co-author =
            "!co() {"
            + " curl --request GET"
            + " --header 'Accept: application/vnd.github+json'"
            + " --url \"https://api.github.com/users/$@\""
            + " | jq --raw-output"
            + " '\"Co-authored-by: \\(.name // .login)"
            + " <\\(.id)+\\(.login)@users.noreply.github.com>\"'"
            + " ;};"
            + " co";
        };
      };
    };
  };
}
