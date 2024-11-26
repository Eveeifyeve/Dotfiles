{ pkgs, git, ... }:
{
  programs = {
    git = {
      enable = true;
      delta = {
        enable = true;
      };
      extraConfig = {
        core.editor = "nvim";
        credential.helper = "store";
        github.user = git.username;
        github.email = git.email;
        push.autoSetupRemote = true;
        user = {
          name = git.username;
          email = git.email;
        };
      };
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
      };
      userEmail = git.email;
      userName = git.username;
    };
    gh = {
      enable = true;
      extensions = with pkgs; [ (callPackage ../../custom-pkgs/gh-combine-prs.nix { }) ];
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
