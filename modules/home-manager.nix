{
  config,
  pkgs,
  email,
  ...
}:
{
  programs = {
    home-manager.enable = true;
    tmux = {
      enable = true;
      plugins = with pkgs; [ tmuxPlugins.catppuccin ];
      extraConfig = builtins.readFile ./tmux.conf;
    };
    git = {
      enable = true;
      delta = {
        enable = true;
      };
      extraConfig = {
        core.editor = "vscode";
        credential.helper = "store";
        github.user = config.home.username;
        push.autoSetupRemote = true;
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
      userEmail = email;
      userName = config.home.username;
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    starship = {
    enable = true;
    settings = {
      # git_status = {
      #   conflicted = "⚔️ ";
      #   ahead = "🏎️ 💨 ×${count} ";
      #   behind = "🐢 ×${count} ";
      #   diverged = "🔱 🏎️ 💨 ×${ahead_count} 🐢 ×${behind_count} ";
      #   untracked = "🛤️  ×${count} ";
      #   stashed = "📦 ";
      #   modified = "📝 ×${count} ";
      #   staged = "🗃️  ×${count} ";
      #   renamed = "📛 ×${count} ";
      #   deleted = "🗑️  ×${count} ";
      #   style = "bright-white";
      #   format = "$all_status$ahead_behind";
      # };
    };
  };
  zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ ];
    };
  };
  gh = {
    enable = true;
    extensions = with pkgs; [
      callPackage ../overlays/gh-combine-prs.nix {}
    ];
  };
    gpg.enable = true;
    ssh.enable = true;
  };
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    warn-dirty = false;
  };
  nixpkgs.config = {
    allowUnfree = true;
  };
  home = {
    file = {
      ".tmux.conf".source = ./tmux.conf;
    };
  };
}
