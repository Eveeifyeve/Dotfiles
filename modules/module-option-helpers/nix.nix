{
  lib,
  config,
  ...
}:
{
  options.nix.settings = {
    keep-outputs = lib.mkOption { type = lib.types.bool; };
    accept-flake-config = lib.mkOption { type = lib.types.bool; };
    experimental-features = lib.mkOption {
      type = lib.types.listOf lib.types.singleLineStr;
      default = [ ];
    };
    extra-system-features = lib.mkOption {
      type = lib.types.listOf lib.types.singleLineStr;
      default = [ ];
    };

  };
  config = {
    nix.settings = {
      accept-flake-config = true;
      keep-outputs = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };

    nixos.modules.base = {
      nix = {
        inherit (config.nix) settings;
      };
    };

    darwin.modules.base = {
      nix = {
        inherit (config.nix) settings;
      };
    };
  };
}
