{ pkgs, ... }:
{
  programs = {
    git = {
      enable = true;
      delta = {
        enable = true;
        package = pkgs.callPackage ../../custom-pkgs/git-delta.nix { };
      };
      extraConfig =
      let 
        username = "eveeifyeve";
        email = "88671402+Eveeifyeve@users.noreply.github.com";
      in
      {
        core.editor = "vscode";
        credential.helper = "store";
        github.user = username;
        github.email = email;
        push.autoSetupRemote = true;
        user = {
          name = username;
          email = email;
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
      userEmail = "88671402+Eveeifyeve@users.noreply.github.com";
      userName = "eveeifyeve";
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
}
