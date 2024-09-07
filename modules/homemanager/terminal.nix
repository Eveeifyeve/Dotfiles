{ pkgs, ... }:
{
  programs = {
    zsh = {
      enable = true;
      oh-my-zsh = {
        enable = true;
        plugins = [ "vi-mode" ];
      };
      envExtra = ''
        # Ensure Nix is sourced. Necessary when /etc/zshrc file loses this same code block on macOS upgrades
        	if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
        	  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
        	    fi

        	    '';
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
