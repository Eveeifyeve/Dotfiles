{ lib, ... }:
{
  nixos.modules.base = {
    programs.zsh.enable = true;
  };

  homeManager.modules.base =
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

            				${lib.getExe pkgs.fastfetch}
                    	'';
        };
      };
    };
}
