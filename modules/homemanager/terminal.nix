{ pkgs, ... }:
{
  programs = {
    zsh = {
      enable = true;
      oh-my-zsh = {
        enable = true;
        plugins = [ ];
      };
    };
    tmux = {
      enable = true;
      plugins = with pkgs; [ tmuxPlugins.catppuccin ];
      extraConfig = builtins.readFile ./tmux.conf;
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
  };
  home.file.".tmux.conf".source = ./tmux.conf;
}
