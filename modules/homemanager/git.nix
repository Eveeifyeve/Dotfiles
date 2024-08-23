{
  pkgs,
  ...
}:
let 
  git = {
    email = "88671402+Eveeifyeve@users.noreply.github.com";
    name = "eveeifyeve";
    editor = "vscode";
  };
in
{
  programs = {
    git = {
      enable = true;
      delta = {
        enable = true;
        package = pkgs.callPackage ../../custom-pkgs/git-delta.nix {};
      };
      extraConfig = {
        core.editor = git.editor;
        credential.helper = "store";
        github.user = git.name;
        github.email = git.email;
        push.autoSetupRemote = true;
        user = {
          name = git.name;
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
      userEmail = "88671402+Eveeifyeve@users.noreply.github.com";
      userName = git.name;
    };
  gh = {
    enable = true;
    extensions = with pkgs; [
      (callPackage ../../custom-pkgs/gh-combine-prs.nix {})
    ];
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