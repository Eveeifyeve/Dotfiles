{
  nixos.modules.base = {
    nix.optimise.automatic = true;
  };

  darwin.modules.base = {
    nix.optimise.automatic = true;
  };
}
