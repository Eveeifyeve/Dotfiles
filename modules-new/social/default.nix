{lib, config, ...}
let
  inherit (lib) types;
  cfg = config.social;
in
{
	imports = [
		./element.nix
		./discord.nix
	];

	options.social.enable = lib.mkOption {
		types = types.bool;
		default = false;
	};
}
