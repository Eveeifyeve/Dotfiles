{ pkgs, git, ... }:
{
  programs = {
    git = {
      enable = true;
      settings = {
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
        };

        core.editor = "nvim";
        credential.helper = "store";
        github.user = git.username;
        github.email = git.email;
        merge.tool = "nvim";
        mergetool.nvim.cmd = ''nvim "$MERGED"'';
        mergetool.prompt = false;
        push.autoSetupRemote = true;
        user = {
          name = git.username;
          email = git.email;
        };
      };
    };
    delta = {
      enable = true;
      enableGitIntegration = true;
    };
    gh = {
      enable = true;
      extensions = with pkgs; [ (callPackage ../../custom-pkgs/gh-combine-prs.nix { }) ];
      settings = {
        git_protocol = "ssh";
        prompt = "enabled";

        aliases = {
          co = "pr checkout";
          pv = "pr view";
        };
      };
    };
    # home.file.".gitconfig" = {
    #   text = ''
    #     [user]
    #       name = ${git.name}
    #       email = ${git.email}
    #     [core]
    #       autocrlf = input
    #   '';
    # };
  };
  home.packages = [ pkgs.codeberg-cli ];
}
