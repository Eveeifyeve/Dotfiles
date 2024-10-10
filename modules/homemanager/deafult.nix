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
    ssh.enable = true;
  };
	home.shellAliases = {
		proc = "ps u | head -n1 && ps aux | rg -v '\\srg\\s-\\.' | rg";
		gitr = ''
				gitr () {
					for f in $(find . -type d -name .git | awk -F"/.git$" '{print $1}');  do
						echo
						echo "................................ (cd $f && git $*) ........................................."
						echo
						(cd $f && git $*)
					done
			}
		'';
		cat = "bat";
	};
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    warn-dirty = false;
		sandbox = true;
  };
  nixpkgs.config = {
    allowUnfree = true;
  };
 }
