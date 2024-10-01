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
      plugins = with pkgs; [
			{
				plugin = tmuxPlugins.catppucin;
				extraConfig = ''
					set -g @catppuccin_flavour 'mocha'
					set -g @catppuccin_window_tabs_enabled on
					set -g @catppuccin_date_time "%H:%M"
				'';
			}
			{
				plugin = tmuxPlugins.resurrect;
				extraConfig = ''
					set -g @resurrect-strategy-nvim 'session'
					set -g @resurrect-save 'S'
					set -g @resurrect-restore 'R'
				'';
			}
			{
				plugin = tmuxPlugins.continuum;
				extraConfig = ''
					set -g @continuum-restore 'on'
					set -g @continuum-boot 'on'
					set -g @continuum-save-interval '10'
				'';
			}
			];
			disableConfirmationPrompt = true;
			newSession = true;
      extraConfig = ''
				set -g prefix C-s
				set -g mouse on
				set-option -g status-position top

				#Basic Vim keybindings
				bind-key h select-pane -L
				bind-key j select-pane -D
				bind-key k select-pane -U
				bind-key l select-pane -R
			'';
    };
    starship.enable = true;
  };
}
