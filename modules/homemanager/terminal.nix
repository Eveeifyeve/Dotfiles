{ pkgs, ... }:
{
  programs = {
    zsh = {
      enable = true;
      oh-my-zsh = {
        enable = true;
        plugins = [ "vi-mode" ];
      };
      initContent = ''
        	        # Ensure Nix is sourced. Necessary when /etc/zshrc file loses this same code block on macOS upgrades
                        if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
                          . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
        		. /nix/var/nix/profiles/default/etc/profile.d/nix.sh
                            fi
        	'';
    };
    nushell = {
      enable = true;
    };
    tmux = {
      enable = true;
      shell = "${pkgs.nushell}/bin/nushell";
      plugins = with pkgs; [
        # {
        #   plugin = tmuxPlugins.resurrect;
        #   extraConfig = ''
        #     set -g @resurrect-strategy-nvim 'session'
        #     set -g @resurrect-save 'S'
        #     set -g @resurrect-restore 'R'
        #   '';
        # }
        {
          plugin = tmuxPlugins.continuum;
          extraConfig = ''
                        set -g @continuum-restore 'on'
                        set -g @continuum-boot 'on'
            						${
                    if pkgs.stdenv.hostPlatform.isDarwin then
                      "set -g @continuum-boot-options 'iterm'"
                    else
                      "set -g @continuum-boot-options 'kitty'"
                  }
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
