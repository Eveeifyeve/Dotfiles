{
  config,
  pkgs,
  username,
  ...
}:
{
  programs = {
    home-manager.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    gpg.enable = true;
		password-store = {
			enable = true;
			settings = {
				PASSWORD_STORE_DIR = "${config.xdg.dataHome}/password-store";
				PASSWORD_STORE_KEY = "EBA9DF00EE9717990BC39BDCBAA8C2C616D55AB3";
			};
		};
    ssh.enable = true;
  };
  home.shellAliases = {
    # proc = "ps u | head -n1 && ps aux | rg -v '\\srg\\s-\\.' | rg";
		#  gitr = ''
		#    	gitr () {
		#    		for f in $(find . -type d -name .git | awk -F"/.git$" '{print $1}');  do
		#    			echo
		#    			echo "................................ (cd $f && git $*) ........................................."
		#    			echo
		#    			(cd $f && git $*)
		#    		done
		#    }
		#  '';
    cat = "bat";
  };
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    auto-optimise-store = true;
    warn-dirty = false;
  };
}
